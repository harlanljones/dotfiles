#!/usr/bin/env python3
"""Fixture-only tests in the system temporary directory; no candidate execution."""

import contextlib
import copy
import io
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

import inventory
import review


class ReviewTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="skill-review-")
        self.addCleanup(self.tmp.cleanup)
        self.base = Path(self.tmp.name)
        self.source = self.base / "source"
        self.source.mkdir()
        (self.source / "SKILL.md").write_text("Read refs.md.\n")
        (self.source / "refs.md").write_text("Keep this expertise.\n")
        (self.source / "LICENSE").write_text("Original license.\n")
        (self.source / "asset.bin").write_bytes(bytes(range(256)))
        (self.source / "image.svg").write_text('<svg xmlns="http://www.w3.org/2000/svg"/>\n')
        (self.source / "script.sh").write_text("#!/bin/sh\nexit 97 # NEVER EXECUTE\n")
        (self.source / "link.md").symlink_to("refs.md")
        inherited = self.base / "NOTICE"
        inherited.write_text("Inherited notice.\n")
        self.variant = {"id": "fixture:abc123", "identity": "fixture", "source": "test",
                        "tree": inventory.tree(self.source), "skillMdSha256": inventory.file_hash(self.source / "SKILL.md"),
                        "candidatePath": "library/test/fixture/abc123",
                        "locations": [{"resolvedPath": str(self.source)}],
                        "licenses": [{"path": str(inherited), "sha256": inventory.file_hash(inherited),
                                      "bytes": inherited.stat().st_size, "inTree": False}]}
        self.out = self.base / "out"
        self.out.mkdir()
        self.frozen = {"variants": [self.variant], "gaps": [{"reason": "Unknown builtin coverage"}],
                       "repo": str(self.base), "baseline": {str(inherited): inventory.state(inherited)},
                       "gitBaseline": {"head": "frozen-head", "indexSha256": "frozen-index", "dirtyPaths": []}}
        inventory.materialize(self.frozen, self.out)
        self.root = self.out / self.variant["candidatePath"]
        expected, _ = inventory.expected_candidate(self.variant)
        self.inherited = next(e["path"] for e in expected if e["kind"] == "file" and e["path"].startswith("_inventory-licenses/"))
        self.metadata = {"status": "reviewed", "disposition": "candidate", "pack": "optional-test",
                         "invocation": "Explicit invocation only",
                         "execution": {"recommended": "in-session", "alternatives": ["bounded delegation"]},
                         "reviewedFiles": [e["path"] for e in expected if e["kind"] == "file"],
                         "changes": [{"files": ["SKILL.md", "REVIEW.md", "review.json"], "summary": "Clarify authority; document static review."}],
                         "questions": [{"id": "Q-fixture-authority", "question": "Keep explicit invocation?",
                                        "recommendation": "Yes", "rationale": "Retain user control", "files": ["SKILL.md"]}],
                         "validation": [{"kind": "static", "result": "Walked through invocation; no execution"}],
                         "limitations": ["No live harness evaluation"]}
        (self.root / "SKILL.md").write_text("Read refs.md. Q-fixture-authority: explicit only?\n")
        (self.root / "REVIEW.md").write_text("Candidate review; not approval.\n")
        self.save()
        (self.out / "inventory.json").write_text(json.dumps(self.frozen))

    def save(self):
        (self.root / "review.json").write_text(json.dumps(self.metadata))

    def check(self):
        return review.check_candidate(self.out, self.variant)

    def assert_invalid(self, message):
        result = self.check()
        self.assertNotEqual(result["state"], "contract-valid", result)
        self.assertIn(message, "\n".join(result["errors"]))

    def cli(self, *args):
        output = io.StringIO()
        with contextlib.redirect_stdout(output):
            code = review.main([*args, "--out", str(self.out)])
        return code, json.loads(output.getvalue())

    def test_positive_full_tree_contract_and_no_candidate_execution(self):
        with patch.object(subprocess, "run", side_effect=AssertionError("No subprocess allowed")), patch.object(subprocess, "check_output", side_effect=AssertionError("No subprocess allowed")):
            result = self.check()
        self.assertEqual(result["state"], "contract-valid", result)
        self.assertEqual(result["changedPaths"], ["REVIEW.md", "SKILL.md", "review.json"])

    def test_both_recommendation_forms(self):
        self.metadata["invocation"] = {"mode": "explicit", "automatic": False}
        self.metadata["execution"] = "In-session static inspection"
        self.metadata["validation"] = ["Static walkthrough only"]
        self.metadata["limitations"] = []
        self.save()
        self.assertEqual(self.check()["state"], "contract-valid")

    def test_no_questions_is_explicit_and_valid(self):
        self.metadata["questions"] = []
        self.save()
        self.assertEqual(self.check()["state"], "contract-valid")

    def test_missing_review_and_candidate_counts(self):
        (self.root / "review.json").unlink()
        code, report = self.cli("status")
        self.assertEqual(code, 0)
        self.assertEqual(report["summary"]["missingReviews"], 1)
        self.assertEqual(report["summary"]["unreviewed"], 1)
        self.assertEqual(self.cli("check")[0], 1)
        other = copy.deepcopy(self.variant)
        other["candidatePath"] = "library/test/missing/other"
        report = review.assess({**self.frozen, "variants": [self.variant, other]}, self.out)
        self.assertEqual(report["summary"]["missingCandidates"], 1)
        self.assertEqual(report["summary"]["missingReviews"], 2)
        self.assertFalse(report["summary"]["allSelectedContractsValid"])

    def test_reviewed_file_coverage_including_inherited_license(self):
        for name in ("refs.md", self.inherited, "asset.bin"):
            with self.subTest(name=name):
                self.metadata["reviewedFiles"].remove(name)
                self.save()
                self.assert_invalid("reviewedFiles missing coverage: " + name)
                self.metadata["reviewedFiles"].append(name)

    def test_unknown_duplicate_and_non_regular_reviewed_paths(self):
        for name, message in (("unknown.md", "non-regular/missing"), ("link.md", "non-regular/missing"),
                              ("SKILL.md", "duplicate paths")):
            with self.subTest(name=name):
                self.metadata["reviewedFiles"].append(name)
                self.save()
                self.assert_invalid(message)
                self.metadata["reviewedFiles"].pop()

    def test_fake_statuses_and_required_field_types(self):
        original = copy.deepcopy(self.metadata)
        cases = {"status": ["complete", "approved", "unreviewed", True, {}],
                 "pack": [[], " "], "disposition": [None], "invocation": [[], {}, "", {"enabled": True}],
                 "execution": [0], "changes": [[], ["SKILL.md"]], "questions": [None],
                 "validation": [[], "tested", [{}]], "limitations": [None, [""]]}
        for field, values in cases.items():
            for value in values:
                with self.subTest(field=field, value=value):
                    self.metadata = {**original, field: value}
                    self.save()
                    self.assertNotEqual(self.check()["state"], "contract-valid")
        for field in original:
            self.metadata = dict(original)
            del self.metadata[field]
            self.save()
            self.assert_invalid("Missing required fields")

    def test_unsafe_metadata_paths(self):
        for name in ("../refs.md", "/tmp/refs.md", "./SKILL.md", "x//y", "x/../SKILL.md", "x\\y", "C:/live", "bad\nname"):
            for field in ("reviewedFiles", "changes", "questions"):
                with self.subTest(name=name, field=field):
                    saved = copy.deepcopy(self.metadata)
                    if field == "reviewedFiles":
                        self.metadata[field].append(name)
                    else:
                        self.metadata[field][0]["files"].append(name)
                    self.save()
                    self.assert_invalid("Unsafe relative path")
                    self.metadata = saved

    def test_missing_baseline_files_cannot_be_waived_by_changes(self):
        for name in ("refs.md", "LICENSE", "asset.bin", self.inherited):
            with self.subTest(name=name):
                path = self.root / name
                data = path.read_bytes()
                path.unlink()
                self.metadata["changes"][0]["files"].append(name)
                self.save()
                # refs.md also makes the baseline internal link dangling.
                self.assertNotEqual(self.check()["state"], "contract-valid")
                if name != "refs.md":
                    self.assert_invalid("Missing baseline paths")
                    self.assertIn(name, self.check()["changedPaths"])
                path.write_bytes(data)
                self.metadata["changes"][0]["files"].pop()

    def test_license_and_asset_bytes_preserved_even_with_change_coverage(self):
        for name in ("LICENSE", self.inherited, "asset.bin", "image.svg"):
            with self.subTest(name=name):
                path = self.root / name
                data = path.read_bytes()
                path.write_text("Replacement\n")
                self.metadata["changes"][0]["files"].append(name)
                self.save()
                self.assert_invalid("Preserved license/asset bytes changed: " + name)
                path.write_bytes(data)
                self.metadata["changes"][0]["files"].pop()

    def test_changed_new_directory_mode_and_link_need_changes_coverage(self):
        (self.root / "refs.md").write_text("Edited retained expertise\n")
        (self.root / "new").mkdir()
        (self.root / "new/extra.md").write_text("New expertise\n")
        (self.root / "script.sh").chmod(0o755)
        (self.root / "link.md").unlink()
        (self.root / "link.md").symlink_to("./refs.md")
        self.metadata["reviewedFiles"].append("new/extra.md")
        self.save()
        self.assert_invalid("changes missing coverage")
        for name in ("refs.md", "new", "new/extra.md", "script.sh", "link.md"):
            self.assertIn(name, self.check()["changedPaths"])
            self.metadata["changes"][0]["files"].append(name)
        self.save()
        self.assertEqual(self.check()["state"], "contract-valid", self.check())

    def test_new_supporting_file_requires_reviewed_coverage(self):
        (self.root / "extra.md").write_text("New\n")
        self.metadata["changes"][0]["files"].append("extra.md")
        self.save()
        self.assert_invalid("reviewedFiles missing coverage: extra.md")

    def test_text_suffixed_binary_cannot_be_replaced_with_text(self):
        original = b"Binary\0asset"
        (self.source / "refs.md").write_bytes(original)
        for entry in self.variant["tree"]["entries"]:
            if entry["path"] == "refs.md":
                entry.update(sha256=inventory.digest(original), bytes=len(original))
        (self.root / "refs.md").write_text("Innocent replacement\n")
        self.metadata["changes"][0]["files"].append("refs.md")
        self.save()
        self.assert_invalid("Preserved license/asset bytes changed: refs.md")

    def test_text_edits_fail_closed_when_original_bytes_unavailable(self):
        (self.source / "SKILL.md").write_text("Drifted original\n")
        self.assert_invalid("Original bytes unavailable")

    def test_unsafe_links_and_linked_review_artifacts(self):
        link = self.root / "escape"
        for target in (str(self.source), "missing", "escape", str(self.root / "refs.md")):
            with self.subTest(target=target):
                link.symlink_to(target)
                self.assertNotEqual(self.check()["state"], "contract-valid")
                link.unlink()
        for name in ("review.json", "REVIEW.md"):
            path = self.root / name
            data = path.read_bytes()
            path.unlink()
            path.symlink_to("refs.md")
            self.assert_invalid(name + " must be a regular file")
            path.unlink()
            path.write_bytes(data)

    def test_candidate_root_and_parent_links_rejected(self):
        self.root.rename(self.root.with_name("moved"))
        self.root.symlink_to("moved")
        self.assert_invalid("may not be a link")
        other = self.base / "other"
        other.mkdir()
        (other / "library").symlink_to(self.out / "library")
        self.assertIn("may not be a link", str(review.check_candidate(other, self.variant)["errors"]))

    def test_baseline_file_type_change_rejected(self):
        (self.root / "LICENSE").unlink()
        (self.root / "LICENSE").symlink_to("refs.md")
        self.assert_invalid("Baseline path type changed: LICENSE")

    def test_excluded_new_content_is_not_invisible(self):
        (self.root / ".cache").mkdir()
        (self.root / ".cache/new.txt").write_text("Hidden\n")
        self.assert_invalid("Excluded candidate content")

    def test_questions_need_all_fields_and_inline_exact_ids_in_every_file(self):
        question = self.metadata["questions"][0]
        question["files"].append("refs.md")
        self.save()
        self.assert_invalid("missing inline in refs.md")
        (self.root / "refs.md").write_text("Q-fixture-authority-longer is not the question\n")
        self.metadata["changes"][0]["files"].append("refs.md")
        self.save()
        self.assert_invalid("missing inline in refs.md")
        (self.root / "refs.md").write_text("Q-fixture-authority: decide\n")
        self.assertEqual(self.check()["state"], "contract-valid", self.check())
        for field in ("id", "question", "recommendation", "rationale", "files"):
            value = question.pop(field)
            self.save()
            self.assertNotEqual(self.check()["state"], "contract-valid")
            question[field] = value
        question["files"] = ["REVIEW.md"]
        self.save()
        self.assert_invalid("supporting regular file")

    def test_duplicate_question_ids_and_empty_review_rejected(self):
        self.metadata["questions"].append(copy.deepcopy(self.metadata["questions"][0]))
        self.save()
        self.assert_invalid("duplicate question id")
        (self.root / "REVIEW.md").write_text(" \n")
        self.assert_invalid("REVIEW.md must be nonempty")

    def test_invalid_json_duplicate_keys_and_nonobject_metadata(self):
        for raw in ('{"status":', '{"status":"reviewed","status":"reviewed"}', '[]', '{"status":NaN}'):
            (self.root / "review.json").write_text(raw)
            self.assertNotEqual(self.check()["state"], "contract-valid")

    def test_filters_no_match_and_read_only_commands(self):
        before = inventory.tree(self.out)
        self.assertEqual(self.cli("check", "--source", "test", "--skill", "fixture")[0], 0)
        self.assertEqual(self.cli("check", "--skill", "unknown")[0], 1)
        code, result = self.cli("status", "--source", "unknown")
        self.assertEqual(code, 0)
        self.assertFalse(result["summary"]["allSelectedContractsValid"])
        self.assertEqual(result["summary"]["selectedVariants"], 0)
        self.assertEqual(inventory.tree(self.out), before)

    def test_unknown_candidate_layout_blocks_success(self):
        (self.out / "library/unknown").mkdir()
        code, result = self.cli("check")
        self.assertEqual(code, 1)
        self.assertTrue(result["layoutErrors"])

    def test_deleted_baseline_directory_rejected_and_detected(self):
        (self.root / "empty").mkdir()
        self.variant["tree"]["entries"].append({"path": "empty", "kind": "directory"})
        (self.root / "empty").rmdir()
        self.metadata["changes"][0]["files"].append("empty")
        self.save()
        self.assert_invalid("Missing baseline paths")
        self.assertIn("empty", self.check()["changedPaths"])

    def test_empty_inventory_never_reports_all_valid(self):
        (self.out / "inventory.json").write_text(json.dumps({**self.frozen, "variants": []}))
        code, result = self.cli("check")
        self.assertEqual(code, 1)
        self.assertFalse(result["summary"]["allSelectedContractsValid"])

    def test_index_writes_only_four_reports_and_keeps_gaps_provenance_questions(self):
        before = inventory.tree(self.out)
        code, result = self.cli("index")
        self.assertEqual(code, 0)
        self.assertEqual(set(result["written"]), set(review.REPORTS))
        after = inventory.tree(self.out)
        old = {e["path"]: e for e in before["entries"]}
        new = {e["path"]: e for e in after["entries"]}
        self.assertEqual(set(new) - set(old), set(review.REPORTS))
        self.assertTrue(all(new[p] == entry for p, entry in old.items()))
        index = json.loads((self.out / "INDEX.json").read_text())
        self.assertEqual(index["gaps"], self.frozen["gaps"])
        self.assertEqual(index["provenance"][0]["treeSha256"], self.variant["tree"]["sha256"])
        self.assertIn("Q-fixture-authority", (self.out / "QUESTIONS.md").read_text())
        self.assertIn("not proof", (self.out / "COVERAGE.md").read_text())
        (self.root / "review.json").unlink()
        self.cli("index")
        self.assertIn("unreviewed", (self.out / "INDEX.md").read_text())

    def test_index_refuses_link_and_hardlink_destinations_before_writes(self):
        target = self.base / "protected"
        target.write_text("Protected\n")
        for hard in (False, True):
            path = self.out / "QUESTIONS.md"
            if hard:
                path.hardlink_to(target)
            else:
                path.symlink_to(target)
            with self.assertRaisesRegex(ValueError, "Unsafe report destination"):
                self.cli("index")
            self.assertFalse((self.out / "INDEX.json").exists())
            self.assertEqual(target.read_text(), "Protected\n")
            path.unlink()

    def test_index_handles_malformed_review_fields_without_claiming_completion(self):
        self.metadata.update(pack=["invalid"], questions=[None, {"id": "bad"}])
        self.save()
        code, result = self.cli("index")
        self.assertEqual(code, 0)  # Report generation, not a review gate.
        self.assertEqual(result["summary"]["contractValid"], 0)
        self.assertEqual(result["summary"]["invalidReviews"], 1)
        self.assertIn("MISSING", (self.out / "QUESTIONS.md").read_text())

    def test_index_filters_rejected_without_writes(self):
        with contextlib.redirect_stderr(io.StringIO()), self.assertRaises(SystemExit) as error:
            self.cli("index", "--skill", "fixture")
        self.assertEqual(error.exception.code, 2)
        self.assertFalse(any((self.out / name).exists() for name in review.REPORTS))

    def test_preservation_authorized_edits_only_and_head_index_invariant(self):
        baseline = self.frozen["gitBaseline"]
        baseline["dirtyPaths"] = [{"path": "dirty.txt", "status": " M", "state": {"kind": "file", "sha256": "original"}},
                                  {"path": "docs/skill-review/README.md", "status": "??"}]
        current = copy.deepcopy(baseline)
        current["dirtyPaths"][1] = {"path": "docs/skill-review/new.md", "status": "??"}
        current["dirtyPaths"].extend({"path": p, "status": "??"} for p in review.PROPOSALS)
        with patch.object(review, "git_snapshot", return_value=current):
            self.assertTrue(review.verify_preservation(self.frozen)["worktreePreserved"])
            for field in ("head", "indexSha256"):
                original = current[field]
                current[field] = "changed"
                self.assertFalse(review.verify_preservation(self.frozen)["worktreePreserved"])
                current[field] = original
            current["dirtyPaths"][0]["state"]["sha256"] = "changed"
            result = review.verify_preservation(self.frozen)
            self.assertFalse(result["worktreePreserved"])
            self.assertTrue(result["livePreserved"])

    def test_preservation_detects_new_deleted_and_renamed_protected_dirty_paths(self):
        baseline = self.frozen["gitBaseline"]
        baseline["dirtyPaths"] = [{"path": "dirty.txt", "status": " M", "state": {"kind": "file", "sha256": "original"}}]
        for records in ([], baseline["dirtyPaths"] + [{"path": "new.txt", "status": "??"}],
                        [{"path": "docs/skill-review/renamed.txt", "originalPath": "dirty.txt", "status": " R"}],
                        baseline["dirtyPaths"] + [{"path": "docs/skill-review-sibling/new", "status": "??"}]):
            with self.subTest(records=records), patch.object(review, "git_snapshot", return_value={**baseline, "dirtyPaths": records}):
                self.assertFalse(review.verify_preservation(self.frozen)["worktreePreserved"])

    def test_live_drift_separate_no_cursor_manifest_whitelist(self):
        live = self.base / ".cursor/skills-cursor/.sync-manifest.json"
        live.parent.mkdir(parents=True)
        live.write_text('{"timestamp":"before"}')
        self.frozen["baseline"] = {str(live): inventory.state(live)}
        (self.out / "inventory.json").write_text(json.dumps(self.frozen))
        with patch.object(review, "git_snapshot", return_value=self.frozen["gitBaseline"]):
            self.assertEqual(self.cli("verify-preservation")[0], 0)
            live.write_text('{"timestamp":"after"}')
            code, report = self.cli("verify-preservation")
        self.assertEqual(code, 1)
        self.assertTrue(report["worktreePreserved"])
        self.assertFalse(report["livePreserved"])
        self.assertEqual(report["liveDrift"], [str(live)])
        self.assertEqual(live.read_text(), '{"timestamp":"after"}')

    def test_git_snapshot_parses_unfiltered_renames_and_never_refreshes_index(self):
        destination = "docs/skill-review/inventory.py"
        raw = f" R {destination}\0protected.txt\0?? docs/skill-review/new.md\0 M dirty.txt\0".encode()
        (self.base / "dirty.txt").write_text("Dirty\n")
        with patch.object(subprocess, "check_output", side_effect=[raw, b"head\n", b"index"]) as command:
            result = review.git_snapshot(self.base)
        self.assertEqual(result["dirtyPaths"][0]["originalPath"], "protected.txt")
        self.assertIn("state", result["dirtyPaths"][0])
        self.assertNotIn("state", result["dirtyPaths"][1])
        self.assertEqual(result["indexSha256"], inventory.digest(b"index"))
        for call in command.call_args_list:
            self.assertIn("--no-optional-locks", call.args[0])
            self.assertIn("core.fsmonitor=false", call.args[0])

    def test_git_failure_does_not_hide_live_drift(self):
        live = next(iter(self.frozen["baseline"]))
        Path(live).write_text("Changed\n")
        with patch.object(review, "git_snapshot", side_effect=subprocess.CalledProcessError(1, "git")):
            result = review.verify_preservation(self.frozen)
        self.assertFalse(result["worktreePreserved"])
        self.assertEqual(result["liveDrift"], [live])


if __name__ == "__main__":
    unittest.main()
