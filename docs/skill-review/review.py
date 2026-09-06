#!/usr/bin/env python3
"""Static candidate review checks; never execute candidate code or refresh baselines.

Usage: review.py {status,check,index,verify-preservation} [--out DIRECTORY]
       review.py {status,check} [--source SUBSTRING] [--skill SUBSTRING]

Only `index` writes: INDEX.json, INDEX.md, COVERAGE.md and QUESTIONS.md in --out.
It includes invalid/unreviewed candidates rather than implying completion.

review.json contract (all fields required; additional fields allowed):
  status: exactly "reviewed"; disposition, pack: nonblank strings
  invocation, execution: nonblank string or nonempty descriptive JSON object
  reviewedFiles: unique exact candidate-relative regular-file paths, covering all
    baseline files (including inherited licenses) and new supporting files
  changes: nonempty list of {files: [exact paths], summary: nonblank string};
    cover every added/modified path, including directories and review artifacts
  questions: list of {id, question, recommendation, rationale, files}; IDs start
    Q- and must occur as complete tokens in every referenced supporting text file
  validation: nonempty list of nonblank strings or descriptive JSON objects
  limitations: list of nonblank strings (an empty list is an explicit declaration)

Missing baseline paths and type changes are rejected, not treated as removals.
License hashes and opaque assets (suffix outside inventory.TEXT_EXT) are fixed.
Edited text-suffixed files require a source mirror matching the frozen file hash
to establish that the original was UTF-8 without NULs, not a disguised binary.
If original bytes are unavailable, fail closed rather than guess from a suffix.
No metadata check proves a semantic full-tree read or test execution.
"""

import argparse
import collections
import json
import os
from pathlib import Path, PurePosixPath
import re
import subprocess
import sys

import inventory


OUT = Path(__file__).resolve().parent
REPORTS = ("INDEX.json", "INDEX.md", "COVERAGE.md", "QUESTIONS.md")
ARTIFACTS = {"review.json", "REVIEW.md"}
PROPOSALS = {"docs/optional-agent-skill-packs-implementation-plan.md",
             "docs/optional-agent-skill-packs-ux-proposal.md"}
DISCLAIMER = ("Contract validation is not proof of semantic full-tree reading, "
              "executed validation, human approval, or deployment readiness. "
              "Inventory gaps remain explicit; live preservation is a separate check.")


def relative_path(value):
    if (not isinstance(value, str) or not value or "\\" in value
            or any(ord(c) < 32 or ord(c) == 127 for c in value)):
        raise ValueError(f"Unsafe relative path: {value!r}")
    path = PurePosixPath(value)
    if (path.is_absolute() or any(p in {"", ".", ".."} for p in value.split("/"))
            or re.match(r"^[A-Za-z]:", value)):
        raise ValueError(f"Unsafe relative path: {value!r}")
    return value


def text(value):
    return isinstance(value, str) and bool(value.strip())


def description(value):
    """Permit structured recommendations without prescribing provider vocabulary."""
    if isinstance(value, str):
        return text(value)
    if not isinstance(value, dict) or not value:
        return False
    def informative(item):
        if isinstance(item, str):
            return text(item)
        if isinstance(item, dict):
            return all(text(k) for k in item) and any(informative(v) for v in item.values())
        if isinstance(item, list):
            return any(informative(v) for v in item)
        return False
    return all(text(k) for k in value) and informative(value)


def paths(value, field, nonempty=False):
    if not isinstance(value, list) or (nonempty and not value):
        raise ValueError(f"{field} must be {'a nonempty' if nonempty else 'a'} path list")
    result = [relative_path(p) for p in value]
    if len(result) != len(set(result)):
        raise ValueError(f"{field} contains duplicate paths")
    return set(result)


def read_json(path):
    def unique(pairs):
        result = {}
        for key, value in pairs:
            if key in result:
                raise ValueError(f"Duplicate JSON key: {key}")
            result[key] = value
        return result
    def invalid_constant(value):
        raise ValueError(f"Invalid JSON constant: {value}")
    return json.loads(path.read_text(encoding="utf-8"), object_pairs_hook=unique,
                      parse_constant=invalid_constant)


def check_candidate(out, variant):
    """Return evidence, accumulating independent contract errors where possible."""
    row = {k: variant[k] for k in ("id", "identity", "source", "candidatePath")}
    row.update(state="invalid", errors=[], changedPaths=[], missingFiles=[], review=None)
    errors = row["errors"]
    try:
        relative_path(variant["candidatePath"])
        root = inventory.candidate_path(out, variant)
        if not root.exists():
            row.update(state="missing-candidate", errors=["Candidate directory missing"])
            return row
        expected_list, inherited = inventory.expected_candidate(variant)
        expected = {relative_path(e["path"]): e for e in expected_list}
        if len(expected) != len(expected_list) or ARTIFACTS & expected.keys():
            raise ValueError("Duplicate baseline paths or reserved review artifact collision")
        excluded = []
        actual_tree = inventory.tree(root, exclusions=excluded)
        if any(e["scope"] != "independent-target-only" for e in excluded):
            raise ValueError("Excluded candidate content is not allowed to hide paths")
        actual = {e["path"]: {k: v for k, v in e.items() if k != "candidateTarget"}
                  for e in actual_tree["entries"]}
        for name, entry in actual.items():
            relative_path(name)
            if entry["kind"] == "link" and Path(entry["target"]).is_absolute():
                raise ValueError(f"Absolute candidate link: {name}")
        missing = sorted(expected.keys() - actual.keys())
        row["missingFiles"] = missing
        if missing:
            errors.append("Missing baseline paths (removals unsupported): " + ", ".join(missing))
        row["changedPaths"] = sorted(p for p in expected.keys() | actual.keys()
                                     if expected.get(p) != actual.get(p))
        license_hashes = {lic["sha256"] for lic in variant["licenses"]}
        for name in expected.keys() & actual.keys():
            before, after = expected[name], actual[name]
            if before["kind"] != after["kind"]:
                errors.append(f"Baseline path type changed: {name}")
                continue
            if before["kind"] != "file" or before["sha256"] == after["sha256"]:
                continue
            data = (root / name).read_bytes()
            try:
                data.decode("utf-8")
                binary = b"\0" in data
            except UnicodeDecodeError:
                binary = True
            license_file = (name in inherited or before["sha256"] in license_hashes
                            or re.match(r"(?i)^(licen[cs]e|copying|notice)([._-].*)?$", Path(name).name))
            if license_file or Path(name).suffix.lower() not in inventory.TEXT_EXT or binary:
                errors.append(f"Preserved license/asset bytes changed: {name}")
                continue
            # The baseline stores hashes, not content types. Only hash-matching
            # original bytes can prove that a changed .txt/.md was actually text.
            original = None
            for location in variant["locations"]:
                source_root = Path(location["resolvedPath"])
                source = source_root / name
                try:
                    if (source.resolve(strict=True).is_relative_to(source_root)
                            and source.is_file() and not source.is_symlink()):
                        data = source.read_bytes()
                        if inventory.digest(data) == before["sha256"]:
                            original = data
                            break
                except (OSError, RuntimeError):
                    continue
            if original is None:
                errors.append(f"Original bytes unavailable for binary preservation check: {name}")
            else:
                try:
                    original.decode("utf-8")
                    binary = b"\0" in original
                except UnicodeDecodeError:
                    binary = True
                if binary:
                    errors.append(f"Preserved license/asset bytes changed: {name}")
        for artifact in sorted(ARTIFACTS):
            if actual.get(artifact, {}).get("kind") != "file":
                errors.append(f"{artifact} must be a regular file")
        if "review.json" not in actual:
            row["state"] = "unreviewed"
            return row
        if actual["review.json"]["kind"] != "file":
            return row
        if actual.get("REVIEW.md", {}).get("kind") == "file":
            if not text((root / "REVIEW.md").read_text(encoding="utf-8")):
                errors.append("REVIEW.md must be nonempty")
        review = read_json(root / "review.json")
        if not isinstance(review, dict):
            raise ValueError("review.json must be an object")
        row["review"] = review
        required = {"status", "disposition", "pack", "invocation", "execution",
                    "reviewedFiles", "changes", "questions", "validation", "limitations"}
        if required - review.keys():
            errors.append("Missing required fields: " + ", ".join(sorted(required - review.keys())))
        if review.get("status") != "reviewed":
            errors.append('status must be exactly "reviewed"')
        for field in ("disposition", "pack"):
            if not text(review.get(field)):
                errors.append(f"{field} must be a nonblank string")
        for field in ("invocation", "execution"):
            if not description(review.get(field)):
                errors.append(f"{field} must be a nonblank string or descriptive object")
        validation = review.get("validation")
        if not isinstance(validation, list) or not validation or not all(description(v) for v in validation):
            errors.append("validation must be a nonempty list of descriptions")
        limitations = review.get("limitations")
        if not isinstance(limitations, list) or not all(text(v) for v in limitations):
            errors.append("limitations must be a list of nonblank strings")
        regular = {p for p, e in actual.items() if e["kind"] == "file"}
        baseline_files = {p for p, e in expected.items() if e["kind"] == "file"}
        reviewed = paths(review.get("reviewedFiles"), "reviewedFiles")
        uncovered = (baseline_files | (regular - ARTIFACTS)) - reviewed
        if uncovered:
            errors.append("reviewedFiles missing coverage: " + ", ".join(sorted(uncovered)))
        if reviewed - regular:
            errors.append("reviewedFiles names non-regular/missing paths: " + ", ".join(sorted(reviewed - regular)))
        changes = review.get("changes")
        if not isinstance(changes, list) or not changes:
            raise ValueError("changes must be a nonempty list of {files, summary} objects")
        covered = set()
        for change in changes:
            if not isinstance(change, dict) or not text(change.get("summary")):
                raise ValueError("Each change needs a nonblank summary and files")
            covered |= paths(change.get("files"), "changes.files", nonempty=True)
        if covered - (expected.keys() | actual.keys()):
            errors.append("changes names unknown paths: " + ", ".join(sorted(covered - (expected.keys() | actual.keys()))))
        if set(row["changedPaths"]) - covered:
            errors.append("changes missing coverage: " + ", ".join(sorted(set(row["changedPaths"]) - covered)))
        questions = review.get("questions")
        if not isinstance(questions, list):
            raise ValueError("questions must be a list (empty if none)")
        ids = set()
        for question in questions:
            if not isinstance(question, dict):
                raise ValueError("Each question must be an object")
            for field in ("id", "question", "recommendation", "rationale"):
                if not text(question.get(field)):
                    raise ValueError(f"Question {field} must be a nonblank string")
            qid = question["id"]
            if not re.fullmatch(r"Q-[A-Za-z0-9]+(?:-[A-Za-z0-9]+)+", qid) or qid in ids:
                raise ValueError(f"Invalid or duplicate question id: {qid}")
            ids.add(qid)
            for name in sorted(paths(question.get("files"), "questions.files", nonempty=True)):
                if name not in regular - ARTIFACTS:
                    errors.append(f"Question {qid} must reference a supporting regular file: {name}")
                elif not re.search(r"(?<![A-Za-z0-9_-])" + re.escape(qid) + r"(?![A-Za-z0-9_-])",
                                   (root / name).read_text(encoding="utf-8")):
                    errors.append(f"Question {qid} missing inline in {name}")
        if not errors:
            row["state"] = "contract-valid"
    except (ValueError, OSError, RuntimeError, KeyError, TypeError) as error:
        errors.append(str(error))
    return row


def assess(frozen, out, source="", skill=""):
    selected = [v for v in frozen["variants"] if source in v["source"] and skill in v["identity"]]
    layout_errors = []
    try:
        inventory.check_library_layout(frozen, out)
    except (ValueError, OSError, RuntimeError) as error:
        layout_errors.append(str(error))
    rows = [check_candidate(out, variant) for variant in selected]
    states = collections.Counter(row["state"] for row in rows)
    summary = {"totalVariants": len(frozen["variants"]), "selectedVariants": len(rows),
               "contractValid": states["contract-valid"],
               "unreviewed": len(rows) - states["contract-valid"],
               "missingCandidates": states["missing-candidate"],
               "missingReviews": sum(row["state"] in {"missing-candidate", "unreviewed"} for row in rows),
               "invalidReviews": states["invalid"], "inventoryGaps": len(frozen["gaps"]),
               "allSelectedContractsValid": bool(rows) and states["contract-valid"] == len(rows) and not layout_errors}
    return {"schemaVersion": 1, "summary": summary, "filters": {"source": source, "skill": skill},
            "limitations": DISCLAIMER, "layoutErrors": layout_errors, "candidates": rows,
            "gaps": frozen["gaps"], "graph": frozen.get("graph", {"coverage": "unknown"})}


def authorized(path):
    relative_path(path)
    return path.startswith("docs/skill-review/") or path in PROPOSALS


def git_snapshot(repo):
    """Match inventory's Git representation without its narrower path filter."""
    def git(*args):
        return subprocess.check_output(["git", "--no-optional-locks", "-c", "core.fsmonitor=false", *args], cwd=repo)
    parts = os.fsdecode(git("status", "--porcelain=v1", "-z", "--untracked-files=all")).split("\0")
    records = []
    i = 0
    while i < len(parts) and parts[i]:
        record = {"status": parts[i][:2], "path": parts[i][3:]}
        i += 1
        names = [record["path"]]
        if "R" in record["status"] or "C" in record["status"]:
            if i >= len(parts) or not parts[i]:
                raise ValueError("Malformed Git rename/copy record")
            record["originalPath"] = parts[i]
            names.append(parts[i])
            i += 1
        if not all(authorized(name) for name in names):
            record["state"] = inventory.state(repo / record["path"])
        records.append(record)
    return {"dirtyPaths": records, "head": git("rev-parse", "HEAD").decode().strip(),
            "indexSha256": inventory.digest(git("ls-files", "--stage", "-z"))}


def verify_preservation(frozen):
    """Compare the frozen Git contract and independently report every live drift."""
    result = {"worktreeErrors": [], "liveDrift": [], "liveErrors": []}
    try:
        current = git_snapshot(Path(frozen["repo"]))
        baseline = frozen["gitBaseline"]
        for key in ("head", "indexSha256"):
            if current[key] != baseline[key]:
                result["worktreeErrors"].append(f"Git {key} changed")
        def protected(records):
            values = {}
            for record in records:
                names = [record["path"]] + ([record["originalPath"]] if "originalPath" in record else [])
                if not all(authorized(name) for name in names):
                    values[record["path"]] = record
            return values
        before, after = protected(baseline["dirtyPaths"]), protected(current["dirtyPaths"])
        for path in sorted(before.keys() | after.keys()):
            if before.get(path) != after.get(path):
                result["worktreeErrors"].append(f"Protected dirty path changed: {path}")
    except (ValueError, OSError, KeyError, subprocess.SubprocessError) as error:
        result["worktreeErrors"].append(str(error))
    # No authorized-document filter applies to the broad live baseline.
    for path, expected in frozen["baseline"].items():
        try:
            if inventory.state(Path(path)) != expected:
                result["liveDrift"].append(path)
        except (ValueError, OSError, RuntimeError) as error:
            result["liveErrors"].append({"path": path, "error": str(error)})
    result["worktreePreserved"] = not result["worktreeErrors"]
    result["livePreserved"] = not (result["liveDrift"] or result["liveErrors"])
    return result


def generate_index(report, frozen, out):
    """Explicit report-only writer; never write through existing links/hardlinks."""
    def md(value):
        if not isinstance(value, str):
            value = json.dumps(value, sort_keys=True, ensure_ascii=True)
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("|", "&#124;").replace("\r", " ").replace("\n", "<br>")
    index = ["# Candidate Review Index", "", DISCLAIMER, "",
             "| Source | Skill | Candidate | Contract | Pack | Invocation | Execution |",
             "| --- | --- | --- | --- | --- | --- | --- |"]
    questions = ["# Review Questions", "", "Recommendations are not accepted policy. Invalid contracts are labelled.", ""]
    for row in report["candidates"]:
        review = row["review"] or {}
        index.append("| " + " | ".join(md(value) for value in (
            row["source"], row["identity"], row["candidatePath"], row["state"],
            review.get("pack", "unknown"), review.get("invocation", "unknown"), review.get("execution", "unknown"))) + " |")
        if row["errors"]:
            questions.append(f"Contract errors for {md(row['candidatePath'])}: {md(row['errors'])}\n")
        for question in review.get("questions", []) if isinstance(review.get("questions"), list) else []:
            if not isinstance(question, dict):
                continue
            questions.extend([f"## {md(question.get('id', 'Invalid ID'))}", "",
                              f"Candidate: {md(row['candidatePath'])} ({row['state']})", "",
                              f"Question: {md(question.get('question', 'MISSING'))}", "",
                              f"Recommendation: {md(question.get('recommendation', 'MISSING'))}", "",
                              f"Rationale: {md(question.get('rationale', 'MISSING'))}", "",
                              f"Files: {md(question.get('files', []))}", ""])
    coverage = ["# Review Coverage", "", DISCLAIMER, "", "## Counts", ""]
    coverage.extend(f"- {key}: {value}" for key, value in report["summary"].items())
    coverage.extend(["", "## Layout Errors", "", md(report["layoutErrors"]), "", "## Inventory Gaps", ""])
    coverage.extend("- " + md(gap) for gap in report["gaps"])
    coverage.extend(["", "## Graph Coverage", "", md(report["graph"]), "",
                     "## Outstanding Candidates", ""])
    coverage.extend(f"- {md(row['candidatePath'])}: {row['state']}; {md(row['errors'])}"
                    for row in report["candidates"] if row["state"] != "contract-valid")
    # Retain immutable provenance in the machine index, not just a status count.
    indexed = dict(report, inventoryCreatedAt=frozen.get("createdAt"),
                   provenance=[{k: v.get(k) for k in ("id", "candidatePath", "skillMdSha256", "locations", "licenses", "licenseStatus")}
                               | {"treeSha256": v["tree"]["sha256"]} for v in frozen["variants"]])
    outputs = {"INDEX.json": json.dumps(indexed, indent=2, sort_keys=True) + "\n",
               "INDEX.md": "\n".join(index) + "\n", "COVERAGE.md": "\n".join(coverage) + "\n",
               "QUESTIONS.md": "\n".join(questions) + "\n"}
    for name in REPORTS:
        path = out / name
        if path.is_symlink() or (path.exists() and (not path.is_file() or path.stat().st_nlink != 1)):
            raise ValueError(f"Unsafe report destination: {path}")
    for name, contents in outputs.items():
        # O_NOFOLLOW also rejects a symlink substituted after the preflight.
        fd = os.open(out / name, os.O_WRONLY | os.O_CREAT | os.O_NOFOLLOW, 0o644)
        with os.fdopen(fd, "w", encoding="utf-8") as stream:
            if os.fstat(stream.fileno()).st_nlink != 1:
                raise ValueError(f"Hardlinked report destination: {name}")
            stream.truncate(0)
            stream.write(contents)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("command", choices=("status", "check", "index", "verify-preservation"))
    parser.add_argument("--out", type=Path, default=OUT)
    parser.add_argument("--source", default="", help="case-sensitive source substring (status/check only)")
    parser.add_argument("--skill", default="", help="case-sensitive identity substring (status/check only)")
    args = parser.parse_args(argv)
    if (args.source or args.skill) and args.command not in {"status", "check"}:
        parser.error("filters apply only to status/check; generated indexes always cover the frozen inventory")
    out = args.out.resolve(strict=True)
    frozen = read_json(out / "inventory.json")
    if args.command == "verify-preservation":
        result = verify_preservation(frozen)
        print(json.dumps(result, indent=2, sort_keys=True))
        return 0 if result["worktreePreserved"] and result["livePreserved"] else 1
    result = assess(frozen, out, args.source, args.skill)
    if args.command == "index":
        generate_index(result, frozen, out)
        print(json.dumps({"written": list(REPORTS), "summary": result["summary"], "limitations": DISCLAIMER}, indent=2))
        return 0
    print(json.dumps(result, indent=2, sort_keys=True))
    return 0 if args.command == "status" or result["summary"]["allSelectedContractsValid"] else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except (ValueError, OSError, KeyError, TypeError, RuntimeError) as error:
        print(f"review: {error}", file=sys.stderr)
        sys.exit(1)
