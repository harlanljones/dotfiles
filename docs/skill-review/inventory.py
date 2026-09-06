#!/usr/bin/env python3
"""Bounded, read-only live skill inventory and candidate-only materialization.

No installs, network requests, activation changes or git writes. Only snapshot
and materialize write, exclusively below the explicitly selected output root.
"""

import argparse
import collections
import datetime
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys

import yaml


REPO = Path(__file__).resolve().parents[2]
OUT = Path(__file__).resolve().parent
PRUNE = {".git", "node_modules", "__pycache__", ".pytest_cache", ".mypy_cache",
         ".ruff_cache", ".cache", ".venv", "venv", ".in_use", ".DS_Store"}
HISTORICAL = {"examples", "example", "fixtures", "fixture", "tests", "test",
              "testdata", "__tests__", "_staging"}
TEXT_EXT = {".md", ".mdx", ".txt", ".rst", ".yaml", ".yml", ".json",
            ".toml", ".sh", ".bash", ".py", ".js", ".mjs", ".cjs", ".ts",
            ".tsx", ".html", ".css", ".xml", ".j2", ".tmpl"}
SECRET_NAMES = {".env", ".netrc", ".npmrc", "credentials.json", "auth.json",
                "settings.local.json", "id_rsa", "id_ed25519", "key.txt",
                ".ssh", ".aws", ".gnupg"}
SECRET_PATTERNS = [
    rb"-----BEGIN (?:[A-Z0-9 ]+ )?PRIVATE KEY-----",
    rb"AGE-SECRET-KEY-1[0-9A-Z]{20,}",
    rb"\b(?:gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{40,})\b",
    rb"\b(?:AKIA|ASIA)[A-Z0-9]{16}\b",
    rb"\bsk-(?:proj-|ant-api\d+-)?[A-Za-z0-9_-]{32,}\b",
    rb"\bxox[baprs]-[A-Za-z0-9-]{20,}\b",
]


def digest(data):
    return hashlib.sha256(data).hexdigest()


def encoded(value):
    return json.dumps(value, sort_keys=True, separators=(",", ":")).encode()


def load_json(path):
    try:
        return json.loads(path.read_text())
    except ValueError as error:
        raise ValueError(f"Invalid JSON metadata: {path}: {error}") from error


def file_hash(path):
    h = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            h.update(block)
    return h.hexdigest()


def state(path):
    """Never dereference a link or print file contents in a baseline."""
    if path.is_symlink():
        return {"kind": "link", "target": os.readlink(path)}
    if not path.exists():
        return {"kind": "absent"}
    if path.is_dir():
        return {"kind": "directory", "children": sorted(p.name for p in path.iterdir())}
    if path.is_file():
        return {"kind": "file", "sha256": file_hash(path),
                "bytes": path.stat().st_size, "executable": bool(path.stat().st_mode & 0o111)}
    raise ValueError(f"Unsupported filesystem object: {path}")


def scan_secret(path, data):
    if path.name in SECRET_NAMES or path.suffix.lower() in {".pem", ".key", ".p12", ".pfx"}:
        raise ValueError(f"Refusing potentially private material: {path}")
    if any(re.search(pattern, data) for pattern in SECRET_PATTERNS):
        raise ValueError(f"Secret scan rejected content (not displayed): {path}")


def excluded_name(name):
    if name in PRUNE or name.endswith((".pyc", ".pyo")):
        return "VCS/runtime cache/dependency content; subtree not traversed"
    if name in SECRET_NAMES or (name.startswith(".env.") and name not in {".env.example", ".env.sample", ".env.template"}):
        return "potential secrets; not read or exported; subtree not traversed"
    return None


def tree(root, baseline=None, exclusions=None, secret_scan=True):
    """Hash retained tree; supporting examples remain, nested skills aren't targets."""
    root = root.resolve(strict=True)
    entries = []
    exclusions = exclusions if exclusions is not None else []

    def visit(folder):
        if baseline is not None:
            baseline[str(folder)] = state(folder)
        for path in sorted(folder.iterdir()):
            rel = path.relative_to(root).as_posix()
            reason = excluded_name(path.name)
            if reason:
                exclusions.append({"path": str(path), "reason": reason, "scope": "subtree" if path.is_dir() else "path"})
                continue
            item = {"path": rel}
            observed = state(path)
            if baseline is not None:
                baseline[str(path)] = observed
            kind = observed["kind"]
            if kind == "link":
                target = path.resolve(strict=True)
                if not target.is_relative_to(root):
                    raise ValueError(f"Supporting link escapes skill tree: {path}")
                if any(excluded_name(p) for p in target.relative_to(root).parts):
                    raise ValueError(f"Supporting link points into excluded content: {path}")
                item.update(kind="link", target=observed["target"],
                            candidateTarget=os.path.relpath(target, path.parent))
            elif kind == "directory":
                item["kind"] = kind
            elif kind == "file":
                if secret_scan:
                    scan_secret(path, path.read_bytes())
                item.update(observed)
                if path.name == "SKILL.md" and rel != "SKILL.md":
                    exclusions.append({"path": str(path), "reason": "supporting nested skill; retained in parent candidate, not independent target", "scope": "independent-target-only"})
            else:
                raise ValueError(f"Unexpected tree member: {path}")
            entries.append(item)
            if kind == "directory":
                visit(path)

    visit(root)
    hash_entries = [{k: v for k, v in e.items() if k != "candidateTarget"} for e in entries]
    return {"sha256": digest(encoded(hash_entries)), "entries": entries,
            "bytes": sum(e.get("bytes", 0) for e in entries),
            "files": sum(e["kind"] == "file" for e in entries),
            "supportingInstructionFiles": sum(e["kind"] == "file" and e["path"] != "SKILL.md" and Path(e["path"]).suffix.lower() in TEXT_EXT for e in entries)}


def git_baseline(repo):
    raw = subprocess.check_output(["git", "status", "--porcelain=v1", "-z", "--untracked-files=all"], cwd=repo)
    parts = raw.decode().split("\0")
    entries = []
    i = 0
    while i < len(parts) and parts[i]:
        status, path = parts[i][:2], parts[i][3:]
        i += 1
        record = {"status": status, "path": path}
        if "R" in status or "C" in status:
            record["originalPath"] = parts[i]
            i += 1
        owned = (path.startswith("docs/skill-review/library/") or path in {
            "docs/skill-review/inventory.py", "docs/skill-review/test_inventory.py",
            "docs/skill-review/inventory.json", "docs/skill-review/INVENTORY-NOTES.md"})
        if not owned:
            record["state"] = state(repo / path)
            entries.append(record)
    index = subprocess.check_output(["git", "ls-files", "--stage", "-z"], cwd=repo)
    return {"dirtyPaths": entries, "indexSha256": digest(index),
            "head": subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=repo).decode().strip()}


def slug(name):
    value = re.sub(r"[^a-zA-Z0-9._-]+", "-", name).strip(".-")
    if not value:
        raise ValueError("Empty candidate name")
    return value


def declared_path(candidate, capability, git_path):
    relative = Path(capability)
    prefix = Path(git_path or ".")
    if relative.is_absolute() or ".." in relative.parts or ".." in prefix.parts or prefix.is_absolute():
        raise ValueError("Unsafe declared plugin path")
    direct = candidate / relative
    if direct.is_file():
        return direct
    # Cursor cache payloads are rooted at gitPath, while cloud declarations may
    # still include that repository prefix. Never guess by basename.
    if prefix != Path(".") and relative.is_relative_to(prefix):
        return candidate / relative.relative_to(prefix)
    return direct


def discover(home, repo):
    baseline, exclusions, roots, occurrences, plugins, gaps = {}, [], [], [], [], []
    seen = set()
    manifest_path = repo / ".chezmoidata/agent_skills.yaml"
    manifest = yaml.safe_load(manifest_path.read_text())["agentSkills"]
    baseline[str(manifest_path)] = state(manifest_path)
    for name in ("run_after_23-sync-agent-skills.sh.tmpl", "run_onchange_before_09-install-agent-skills.sh.tmpl", "INDEX.json"):
        baseline[str(repo / name)] = state(repo / name)
    packs = {skill: {"pack": name, "repo": pack["repo"], "version": None,
                     "evidence": str(manifest_path), "certainty": "declared source, installed revision unknown"}
             for name, pack in manifest["packs"].items() for skill in pack["skills"]}

    # Explicit paths only: never recursively search home or application state.
    conventional = [".agents/skills", ".codex/skills", ".config/opencode/skills",
                    ".claude/skills", ".cline/skills", ".cursor/skills", ".gemini/config/skills",
                    ".gemini/skills", ".grok/skills", ".pi/agent/skills",
                    ".config/amp/skills", ".config/goose/skills", ".config/agents/skills",
                    ".copilot/skills", ".config/github-copilot/skills", ".windsurf/skills",
                    ".codeium/windsurf/skills", ".roo/skills", ".continue/skills",
                    ".augment/skills", ".qwen/skills", ".qoder/skills", ".trae/skills",
                    ".trae-cn/skills", ".kiro/skills", ".factory/skills", ".openhands/skills",
                    ".crush/skills", ".config/crush/skills", ".commandcode/skills",
                    ".kode/skills", ".mistral/skills", ".vibe/skills", ".mux/skills",
                    ".neovate/skills", ".pochi/skills", ".adal/skills", ".config/hermes/skills",
                    ".omp/agent/skills", ".opencode/skills"]
    provider_roots = [home / ".cursor/skills-cursor", home / ".codex/skills/.system"]
    allowed = [home / p for p in conventional] + provider_roots
    extras = [Path(e["sourcePath"]) if e["sourcePath"].startswith("/") else home / e["sourcePath"] for e in manifest["sharedExtras"]]
    terminal_roots = [home / ".local/share/terminal-browser/app/skills/codex/terminal-browser"]
    allowed += extras + terminal_roots + [repo / "dot_codex/skills", repo / "dot_config/opencode/skills"]

    def remember_links(path):
        for ancestor in [path, *path.parents]:
            if ancestor.is_symlink():
                baseline[str(ancestor)] = state(ancestor)

    def add_skill(path, source, boundary, provenance=None):
        if str(path) in seen:
            return
        seen.add(str(path))
        remember_links(path)
        resolved = path.resolve(strict=True)
        if not any(resolved.is_relative_to(p.resolve()) for p in allowed):
            raise ValueError(f"Skill root link outside allowlist: {path} -> {resolved}")
        baseline[str(path)] = state(path)
        identity = path.name
        occurrences.append({"identity": identity, "path": str(path), "resolvedPath": str(resolved),
                            "source": source, "boundary": str(boundary.resolve()),
                            "rootLink": os.readlink(path) if path.is_symlink() else None,
                            "provenance": provenance or packs.get(identity, {"version": None, "certainty": "local installed tree; upstream unknown"})})

    def walk(folder, source, boundary, provenance=None, historical=False):
        if not folder.is_dir():
            return
        remember_links(folder)
        baseline[str(folder)] = state(folder)
        for child in sorted(folder.iterdir()):
            if child in provider_roots:
                continue  # Independently inventoried below with provider provenance.
            reason = excluded_name(child.name)
            if reason:
                exclusions.append({"path": str(child), "reason": reason, "scope": "subtree"})
                continue
            if child.name in HISTORICAL and not historical:
                excluded_skills(child, "examples/fixtures/tests outside a current skill; not independent targets")
                continue
            if child.is_dir():
                if (child / "SKILL.md").is_file():
                    if historical:
                        exclusions.append({"path": str(child), "reason": "historical or unselected cache skill", "scope": "subtree", "skillMdSha256": file_hash(child / "SKILL.md")})
                    else:
                        add_skill(child, source, boundary, provenance)
                elif not child.is_symlink():
                    walk(child, source, boundary, provenance, historical)
            elif child.is_symlink():
                baseline[str(child)] = state(child)
                gaps.append({"path": str(child), "reason": "non-skill or broken discovery link"})

    def excluded_skills(folder, reason):
        """Enumerate entrypoints only; never export excluded payloads."""
        paths = []
        if folder.is_dir():
            for current, dirs, files in os.walk(folder, followlinks=False):
                dirs[:] = sorted(d for d in dirs if not excluded_name(d))
                if "SKILL.md" in files:
                    p = Path(current) / "SKILL.md"
                    paths.append({"path": str(p), "sha256": file_hash(p)})
        exclusions.append({"path": str(folder), "reason": reason, "scope": "subtree", "skillEntrypoints": paths})

    def root(path, source, provenance=None):
        roots.append({"path": str(path), "source": source, "exists": path.is_dir()})
        baseline[str(path)] = state(path)
        if path.is_dir():
            if (path / "SKILL.md").is_file():
                add_skill(path, source, path, provenance)
            else:
                walk(path, source, path, provenance)

    # Tracked source inventory is independent of naming-prefix guesses.
    index = json.loads((repo / "INDEX.json").read_text())
    def index_records(value):
        if isinstance(value, dict):
            if "source" in value and "target" in value:
                yield value
            else:
                for item in value.values():
                    yield from index_records(item)
        elif isinstance(value, list):
            for item in value:
                yield from index_records(item)
    tracked = [r for r in index_records(index) if r["source"].endswith("/SKILL.md")]
    for record in tracked:
        path = repo / record["source"]
        root(path.parent, "local-tracked", {"version": None, "repoHead": subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=repo).decode().strip(), "target": record["target"], "certainty": "tracked worktree bytes"})
    for record in index_records(index):
        if "/skills/" in record["source"] and "symlink" in Path(record["source"]).name:
            baseline[str(repo / record["source"])] = state(repo / record["source"])
    for path in conventional:
        root(home / path, "shared" if path == ".agents/skills" else "harness-" + slug(path))
    for path in provider_roots:
        root(path, "provider-cursor" if "skills-cursor" in str(path) else "builtin-codex")
    for path in extras:
        root(path, "provider-" + ("omarchy" if str(path).startswith("/usr/share/omarchy") else "terminal-browser"))
    for path in terminal_roots:
        root(path, "provider-terminal-browser")
    for relative in (".cursor/skills-cursor/.sync-manifest.json", ".codex/skills/.system/.codex-system-skills.marker"):
        baseline[str(home / relative)] = state(home / relative)

    selected = set()
    claude_manifest = home / ".claude/plugins/installed_plugins.json"
    baseline[str(claude_manifest)] = state(claude_manifest)
    if claude_manifest.is_file():
        for name, installs in json.loads(claude_manifest.read_text())["plugins"].items():
            for install in installs:
                path = Path(install["installPath"])
                if not path.is_relative_to(home / ".claude/plugins"):
                    raise ValueError(f"Plugin install path outside bounded root: {path}")
                plugins.append({"provider": "claude", "name": name, **install, "selectionEvidence": str(claude_manifest)})
                selected.add(path)
    cursor_manifest = home / ".cursor/plugins/cache/.cloud-plugin-manifest.json"
    baseline[str(cursor_manifest)] = state(cursor_manifest)
    if cursor_manifest.is_file():
        for plugin in json.loads(cursor_manifest.read_text())["plugins"]:
            version = "release_" + plugin["releaseTag"] if plugin.get("releaseTag") else plugin["resolvedCommitSha"]
            path = home / ".cursor/plugins/cache" / plugin["marketplaceSlug"] / plugin["pluginId"] / version
            marker = Path(str(path) + ".installed")
            baseline[str(marker)] = state(marker)
            if not marker.is_file() or marker.read_text().strip() != plugin["artifactDigest"]:
                gaps.append({"path": str(marker), "reason": "current plugin artifact marker absent or digest mismatch"})
            record = {"provider": "cursor", **plugin, "version": version, "installPath": str(path), "selectionEvidence": str(cursor_manifest)}
            plugins.append(record)
            selected.add(path)
            # Same-version named paths are retained as mirrors, never selected by mtime.
            mirror = path.parent.parent / plugin["name"] / version
            if mirror.is_dir() and mirror != path:
                record["sameVersionMirror"] = str(mirror)
                selected.add(mirror)
    for plugin in plugins:
        path = Path(plugin["installPath"])
        candidates = [path] + ([Path(plugin["sameVersionMirror"])] if "sameVersionMirror" in plugin else [])
        for candidate in candidates:
            allowed.append(candidate)
            if not candidate.is_dir():
                gaps.append({"path": str(candidate), "reason": "manifest-selected plugin payload missing"})
            provenance = {k: plugin[k] for k in ("provider", "name", "version", "gitCommitSha", "resolvedCommitSha", "gitUrl", "selectionEvidence") if k in plugin}
            for meta in (".claude-plugin/plugin.json", ".cursor-plugin/plugin.json"):
                metadata = candidate / meta
                if metadata.is_file():
                    baseline[str(metadata)] = state(metadata)
                    try:
                        value = load_json(metadata)
                        provenance["pluginMetadata"] = {k: value[k] for k in ("version", "license", "repository", "skills") if k in value}
                    except ValueError:
                        gaps.append({"path": str(metadata), "reason": "invalid JSON plugin metadata; selection still backed by installed manifest"})
            before = len(occurrences)
            root(candidate / "skills", "plugin-" + plugin["provider"] + "-" + slug(plugin["name"]), provenance)
            # Boundary includes repository-level licenses, not just the skills folder.
            for occurrence in occurrences[before:]:
                occurrence["boundary"] = str(candidate.resolve())
            for capability in plugin.get("declaredCapabilityPaths", {}).get("skill", []):
                p = declared_path(candidate, capability, plugin.get("gitPath"))
                plugin.setdefault("declaredSkillResolution", []).append({"declared": capability, "resolved": str(p), "exists": p.is_file()})
                if not p.is_file():
                    gaps.append({"path": str(p), "reason": "manifest-declared skill unavailable"})
                elif not any(o["path"] == str(p.parent) for o in occurrences):
                    add_skill(p.parent, "plugin-" + plugin["provider"] + "-" + slug(plugin["name"]), candidate, provenance)
            plugin.setdefault("skillLocations", []).extend(o["path"] for o in occurrences[before:])
            # Non-skill plugin payload is never silently promoted.
            if candidate.is_dir():
                for child in sorted(candidate.iterdir()):
                    if excluded_name(child.name):
                        exclusions.append({"path": str(child), "scope": "subtree", "reason": excluded_name(child.name)})
                    elif child.is_dir() and child.name != "skills" and not any(Path(o["path"]).is_relative_to(child) for o in occurrences[before:]):
                        excluded_skills(child, "current plugin non-skill payload; not independent rewrite targets")

    for provider in (".claude", ".cursor"):
        cache = home / provider / "plugins/cache"
        roots.append({"path": str(cache), "source": "plugin-cache-selection", "exists": cache.is_dir()})
        if cache.is_dir():
            baseline[str(cache)] = state(cache)
            for marketplace in sorted(cache.iterdir()):
                if not marketplace.is_dir():
                    continue
                baseline[str(marketplace)] = state(marketplace)
                for package in sorted(marketplace.iterdir()):
                    if not package.is_dir():
                        continue
                    baseline[str(package)] = state(package)
                    for version in sorted(package.iterdir()):
                        if version.is_dir() and version not in selected:
                            excluded_skills(version, "cache version not selected by current installed manifest (historical or uninstalled)")
        for suffix in ("plugins/marketplaces", "plugins/local"):
            path = home / provider / suffix
            if path.exists():
                excluded_skills(path, "marketplace/catalog/staging or local plugin content without current selection evidence")

    # Check only current manager-selected installations, not all installed versions.
    for tool in ("opencode", "codex", "claude", "gemini", "pi", "github:can1357/oh-my-pi"):
        result = subprocess.run(["mise", "where", tool], capture_output=True, text=True)
        if result.returncode:
            gaps.append({"provider": tool, "reason": "current installation not resolved by mise"})
            continue
        path = Path(result.stdout.strip())
        if not path.is_relative_to(home / ".local/share/mise/installs"):
            raise ValueError(f"Unexpected manager path: {path}")
        roots.append({"path": str(path), "source": "current-provider-install", "exists": path.is_dir(), "tool": tool, "version": path.name})
        allowed.append(path)
        # Glob-free walk, pruning dependencies and only reading SKILL.md trees.
        found = []
        for current, dirs, files in os.walk(path, followlinks=False):
            for directory in list(dirs):
                if excluded_name(directory):
                    exclusions.append({"path": str(Path(current) / directory), "scope": "subtree", "reason": "provider dependency/runtime tree not traversed"})
            dirs[:] = sorted(d for d in dirs if not excluded_name(d))
            if "SKILL.md" in files:
                skill = Path(current)
                if any(p in HISTORICAL for p in skill.relative_to(path).parts):
                    excluded_skills(skill, "provider installation example/fixture, not builtin")
                else:
                    root(skill, "builtin-" + slug(tool), {"version": path.name, "provider": tool, "certainty": "current mise installation"})
                    found.append(str(skill))
                dirs[:] = []
        gaps.append({"provider": tool, "path": str(path), "reason": "embedded/provider builtin completeness unknown; binary payload not reconstructed", "accessibleSkillTrees": found})

    return {"roots": roots, "occurrences": occurrences, "plugins": plugins,
            "baseline": baseline, "exclusions": exclusions, "gaps": gaps,
            "manifest": {"path": str(manifest_path), "packs": len(manifest["packs"]),
                         "declaredSkills": len(packs), "trackedSkillTrees": len(tracked)}}


def freeze(home, repo):
    git = git_baseline(repo)
    inventory = discover(home, repo)
    variants = {}
    trees = {}
    for occurrence in inventory["occurrences"]:
        root = Path(occurrence["resolvedPath"])
        if str(root) not in trees:
            trees[str(root)] = tree(root, inventory["baseline"], inventory["exclusions"])
        content = trees[str(root)]
        key = occurrence["identity"] + ":" + content["sha256"]
        occurrence["variant"] = key
        if key not in variants:
            variants[key] = {"id": key, "identity": occurrence["identity"], "status": "unreviewed",
                             "tree": content, "skillMdSha256": file_hash(root / "SKILL.md"),
                             "locations": [], "licenses": []}
        variant = variants[key]
        variant["locations"].append(occurrence)
        # Inherited licenses are copied separately and do not alter source-tree identity.
        boundary = Path(occurrence["boundary"])
        if not root.is_relative_to(boundary):
            boundary = root  # Root link provenance must not permit arbitrary parent traversal.
        parent = root
        while parent.is_relative_to(boundary):
            for p in sorted(parent.iterdir()):
                if p.is_file() and not p.is_symlink() and re.match(r"(?i)^(licen[cs]e|copying|notice)([._-].*)?$", p.name):
                    scan_secret(p, p.read_bytes())
                    inventory["baseline"][str(p)] = state(p)
                    record = {"path": str(p), "sha256": file_hash(p), "bytes": p.stat().st_size,
                              "inTree": p.is_relative_to(root)}
                    if record not in variant["licenses"]:
                        variant["licenses"].append(record)
            if parent == boundary:
                break
            parent = parent.parent
    priority = lambda o: (0 if o["source"] == "local-tracked" else 1 if o["source"].startswith(("provider-", "builtin-")) else 2 if o["source"] == "shared" else 3, o["source"], o["path"])
    for variant in variants.values():
        variant["locations"].sort(key=priority)
        canonical = variant["locations"][0]
        source = canonical["source"]
        if source == "shared" and "pack" in canonical["provenance"]:
            source = "pack-" + canonical["provenance"]["pack"]
        variant["source"] = source
        variant["candidatePath"] = f"library/{slug(source)}/{slug(variant['identity'])}/{variant['tree']['sha256'][:12]}"
        variant["licenseStatus"] = "files-preserved" if variant["licenses"] else "no license file found within bounded source ancestry; permission unknown"
    candidate_paths = [v["candidatePath"] for v in variants.values()]
    if len(candidate_paths) != len(set(candidate_paths)):
        raise ValueError("Short hash/slug candidate path collision")
    inventory["variants"] = sorted(variants.values(), key=lambda v: v["candidatePath"])
    del inventory["occurrences"]
    inventory.update(schemaVersion=1, createdAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),
                     home=str(home), repo=str(repo), gitBaseline=git,
                     graph={"project": None, "generation": None, "coverage": "unknown; MCP unavailable; bounded source fallback"},
                     policy={"treeHash": "SHA-256 of canonical JSON sorted traversal entries: relative path, kind, file SHA-256/bytes/executable or exact link string; directories included; excluded subtrees omitted", "identity": "skill directory basename; equal identity + full retained tree hash groups mirrors", "links": "root links dereferenced within explicit allowlist; internal links preserved as relative candidate-local links; external/broken supporting links rejected", "scan": "private filenames excluded; private-key and common token signatures reject export; heuristic scan is not proof of absence of secrets", "exclusions": "subtree exclusions name the pruning boundary, not an enumeration of its private/runtime contents; nested skill files retained as support are not separate targets"})
    inventory["counts"] = counts(inventory)
    return inventory


def counts(inventory):
    variants = inventory["variants"]
    locations = [o for v in variants for o in v["locations"]]
    inherited = [lic for v in variants for lic in expected_candidate(v)[1].values()]
    return {"identities": len({v["identity"] for v in variants}), "variants": len(variants),
            "uniqueFullTreeHashes": len({v["tree"]["sha256"] for v in variants}),
            "uniqueSkillMdHashes": len({v["skillMdSha256"] for v in variants}),
            "locations": len(locations), "resolvedSkillRoots": len({o["resolvedPath"] for o in locations}),
            "rootLinks": sum(o["rootLink"] is not None for o in locations),
            "sharedIdentities": len({o["identity"] for o in locations if o["path"].startswith(inventory["home"] + "/.agents/skills/")}),
            "plugins": len(inventory["plugins"]), "pluginsByProvider": dict(collections.Counter(p["provider"] for p in inventory["plugins"])),
            "candidateFiles": sum(v["tree"]["files"] for v in variants),
            "candidateTreeBytes": sum(v["tree"]["bytes"] for v in variants),
            "inheritedLicenseCopies": len(inherited), "inheritedLicenseBytes": sum(lic["bytes"] for lic in inherited),
            "variantsWithLicenseFiles": sum(bool(v["licenses"]) for v in variants),
            "supportingInstructionFiles": sum(v["tree"]["supportingInstructionFiles"] for v in variants),
            "exclusions": len(inventory["exclusions"]),
            "excludedEntrypoints": sum(len(e.get("skillEntrypoints", [])) for e in inventory["exclusions"]),
            "baselinePaths": len(inventory["baseline"]), "rootsProbed": len(inventory["roots"]),
            "gaps": len(inventory["gaps"])}


def verify_live(inventory):
    failures = [path for path, expected in inventory["baseline"].items() if state(Path(path)) != expected]
    if failures:
        raise ValueError("Baseline changed: " + ", ".join(failures[:30]))


def verify_worktree(inventory):
    if git_baseline(Path(inventory["repo"])) != inventory["gitBaseline"]:
        raise ValueError("Unrelated git worktree/index baseline changed")


def expected_candidate(variant):
    entries = []
    for source in variant["tree"]["entries"]:
        entry = {k: v for k, v in source.items() if k != "candidateTarget"}
        if entry["kind"] == "link":
            entry["target"] = source["candidateTarget"]
        entries.append(entry)
    licenses = {}
    for license_file in variant["licenses"]:
        if not license_file["inTree"]:
            name = "_inventory-licenses/" + license_file["sha256"][:12] + "-" + Path(license_file["path"]).name
            licenses[name] = license_file
    if licenses:
        if any(e["path"].split("/")[0] == "_inventory-licenses" for e in entries):
            raise ValueError("Reserved provenance path collision")
        entries.append({"path": "_inventory-licenses", "kind": "directory"})
        entries.extend({"path": name, "kind": "file", "sha256": lic["sha256"], "bytes": lic["bytes"], "executable": False} for name, lic in licenses.items())
    return sorted(entries, key=lambda e: e["path"]), licenses


def candidate_path(out, variant):
    relative = Path(variant["candidatePath"])
    if relative.is_absolute() or ".." in relative.parts or relative.parts[0] != "library":
        raise ValueError("Unsafe candidate path")
    path = out / relative
    for parent in [path, *path.parents]:
        if parent == out:
            break
        if parent.is_symlink():
            raise ValueError(f"Candidate parent/root may not be a link: {parent}")
    return path


def check_candidate(path, variant):
    actual = tree(path)
    expected, _ = expected_candidate(variant)
    entries = sorted(({k: v for k, v in e.items() if k != "candidateTarget"} for e in actual["entries"]), key=lambda e: e["path"])
    # No exclusions are allowed to conceal newly added candidate content.
    excluded = []
    tree(path, exclusions=excluded)
    if entries != expected or any(e["scope"] != "independent-target-only" for e in excluded):
        raise ValueError(f"Candidate differs; refusing overwrite: {path}")


def check_library_layout(inventory, out):
    library = out / "library"
    expected = {v["candidatePath"] for v in inventory["variants"]}
    if not library.exists():
        return
    if library.is_symlink():
        raise ValueError("Candidate library may not be a link")
    def visit(folder):
        for child in folder.iterdir():
            rel = child.relative_to(out).as_posix()
            if child.is_symlink() or not child.is_dir():
                raise ValueError(f"Unexpected library layout member: {child}")
            if rel in expected:
                continue
            if not any(p.startswith(rel + "/") for p in expected):
                raise ValueError(f"Unexpected candidate directory: {child}")
            visit(child)
    visit(library)


def materialize(inventory, out):
    verify_live(inventory)
    check_library_layout(inventory, out)
    # Check every existing candidate before writing any new one.
    for variant in inventory["variants"]:
        path = candidate_path(out, variant)
        if path.exists():
            check_candidate(path, variant)
    for variant in inventory["variants"]:
        path = candidate_path(out, variant)
        if path.exists():
            continue
        source = Path(variant["locations"][0]["resolvedPath"])
        expected, licenses = expected_candidate(variant)
        path.mkdir(parents=True)
        for entry in expected:
            dest = path / entry["path"]
            if entry["kind"] == "directory":
                dest.mkdir(exist_ok=True)
            elif entry["kind"] == "link":
                dest.symlink_to(entry["target"])
            else:
                src = Path(licenses[entry["path"]]["path"]) if entry["path"] in licenses else source / entry["path"]
                data = src.read_bytes()
                scan_secret(src, data)
                if digest(data) != entry["sha256"]:
                    raise ValueError(f"Source changed during copy: {src}")
                with dest.open("xb") as stream:
                    stream.write(data)
                dest.chmod(0o755 if entry["executable"] else 0o644)
        check_candidate(path, variant)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("command", choices=("snapshot", "materialize", "verify-live", "verify-worktree", "check", "summary", "select"))
    parser.add_argument("--out", type=Path, default=OUT)
    parser.add_argument("--home", type=Path, default=Path.home())
    parser.add_argument("--source", default="")
    parser.add_argument("--skill", default="")
    parser.add_argument("--offset", type=int, default=0)
    parser.add_argument("--limit", type=int, default=100000)
    args = parser.parse_args()
    out = args.out.resolve()
    file = out / "inventory.json"
    if args.command == "snapshot":
        if file.exists() or (out / "library").exists():
            raise ValueError("Snapshot is immutable; inventory/library already exists")
        inventory = freeze(args.home.resolve(), REPO)
        verify_live(inventory)
        verify_worktree(inventory)
        with file.open("x") as stream:
            json.dump(inventory, stream, indent=2, sort_keys=True)
            stream.write("\n")
    else:
        inventory = json.loads(file.read_text())
    if args.command == "materialize":
        materialize(inventory, out)
    elif args.command == "verify-live":
        verify_live(inventory)
        print("LIVE_BASELINE_OK")
    elif args.command == "verify-worktree":
        verify_worktree(inventory)
        print("WORKTREE_BASELINE_OK")
    elif args.command == "check":
        check_library_layout(inventory, out)
        for variant in inventory["variants"]:
            check_candidate(candidate_path(out, variant), variant)
        print("MATERIALIZATION_OK")
    elif args.command == "select":
        selected = [v for v in inventory["variants"] if args.source in v["source"] and args.skill in v["identity"]]
        print(json.dumps([{k: v[k] for k in ("id", "identity", "source", "status", "candidatePath")} for v in selected[args.offset:args.offset + args.limit]], indent=2))
    if args.command in {"snapshot", "summary", "materialize"}:
        print(json.dumps(counts(inventory), indent=2, sort_keys=True))


if __name__ == "__main__":
    try:
        main()
    except (ValueError, OSError) as error:
        print(f"inventory: {error}", file=sys.stderr)
        sys.exit(1)
