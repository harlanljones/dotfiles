#!/usr/bin/env python3
"""Generate the machine- and human-readable dotfiles index.

Writes two generated artifacts at the repository root:

    INDEX.json  — canonical, machine-readable. Consumed by the showcase app
                  and by development agents to locate files without guessing
                  chezmoi source-name encoding.
    INDEX.md    — a rendering of the same data for humans.

Both files are GENERATED. Do not hand-edit them; edit this script (or the
category rules below) and regenerate. CI runs `--check` and fails the build
when either artifact is stale.

Usage:
    python3 docs/generate_index.py              # write both artifacts
    python3 docs/generate_index.py --check      # non-zero exit if stale
    python3 docs/generate_index.py --audit-showcase [PATH]
                                                # report drift between the
                                                # showcase manifest's declared
                                                # live paths and this index

The index is derived from `git ls-files`, so it can never describe a file that
is not tracked, and every tracked file is accounted for exactly once. Source
names are decoded into home-directory targets using chezmoi's documented
prefix/suffix grammar (AGENTS.md §2); nothing is executed and chezmoi itself is
not required, so the script runs identically on a laptop and in CI.

The generated artifacts deliberately carry no showcase data. The showcase is a
submodule pinned to a commit, so folding its manifest into the index would make
`--check` depend on whether submodules were checked out and on which commit is
pinned — a plain `actions/checkout` would then report a false staleness. The
dependency runs one way instead: the showcase reads `INDEX.json` to locate
dotfiles, and `--audit-showcase` is the opt-in reverse check that reports when a
`livePath` the showcase declares no longer corresponds to a managed target.
"""

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
INDEX_JSON = ROOT / "INDEX.json"
INDEX_MD = ROOT / "INDEX.md"

SCHEMA_VERSION = 1

BANNER = (
    "GENERATED FILE — DO NOT EDIT. "
    "Regenerate with `python3 docs/generate_index.py`; CI gates freshness."
)

# ---------------------------------------------------------------------------
# Repository material that is not a dotfile
#
# These paths are git/repo material rather than things chezmoi applies to the
# home directory. They are indexed under kind="repo" with a stated role so an
# agent reading INDEX.json still learns what they are, instead of them simply
# being absent.
# ---------------------------------------------------------------------------
REPO_MATERIAL = (
    ("INDEX.json", "Generated machine-readable index (this artifact)"),
    ("INDEX.md", "Generated human-readable index (this artifact)"),
    ("README.md", "Human-facing repository overview"),
    ("AGENTS.md", "Authoritative contract for agents working in this repo"),
    ("docs/", "Recovery guide and repository maintenance scripts"),
    ("Documents/", "Non-config content (Cline workflow docs)"),
    (".github/", "CI workflows"),
    ("package.json", "Runtime CLI deps installed outside mise"),
    ("bun.lock", "Lockfile for the above"),
    (".gitignore", "Git tracking rules"),
    (".gitmodules", "Submodule registration"),
    ("dotfiles-showcase", "Submodule — the showcase web app; never applied"),
    ("to-questionnaire-", "Scratch planning documents"),
)

# Chezmoi control files: they steer apply behaviour but are not themselves
# targets in the home directory.
CHEZMOI_CONTROL = (
    ".chezmoi.toml.tmpl",
    ".chezmoiignore.tmpl",
    ".chezmoidata/",
    ".chezmoiexternal",
    ".chezmoiremove",
    ".chezmoiroot",
    ".chezmoiversion",
)

# ---------------------------------------------------------------------------
# Categories
#
# The point of the index is that a human or an agent can answer "where does
# the shell prompt live?" without reading the tree. Categories are matched
# against the DECODED target path (e.g. `.config/starship.toml`), longest
# prefix first, so the grouping reflects what a file does rather than where
# chezmoi's naming scheme happens to put it.
#
# To add a category: add a (target-prefix, category, subsystem) row. Order in
# this tuple does not matter; matching is longest-prefix.
# ---------------------------------------------------------------------------
CATEGORY_RULES = (
    # shell
    (".bashrc", "shell", "bash"),
    (".bash_profile", "shell", "bash"),
    (".zshrc", "shell", "zsh"),
    (".profile", "shell", "posix"),
    (".config/shell/", "shell", "shared shell modules"),
    (".config/bash/", "shell", "bash modules"),
    (".config/zsh/", "shell", "zsh modules"),
    # prompt
    (".config/starship.toml", "prompt", "starship"),
    # terminal & multiplexer
    (".config/ghostty/", "terminal", "ghostty"),
    (".config/herdr/", "terminal", "herdr multiplexer"),
    (".config/btop/", "terminal", "btop"),
    # editor
    (".config/nvim/", "editor", "neovim / LazyVim"),
    (".config/Cursor/", "editor", "cursor"),
    # desktop / window manager
    (".config/hypr/", "desktop", "hyprland"),
    (".config/omarchy/", "desktop", "omarchy"),
    (".config/chrome-flags.conf", "desktop", "chromium"),
    (".local/share/applications/", "desktop", "desktop entries"),
    # version control
    (".config/git/", "vcs", "git"),
    (".config/gh/", "vcs", "github cli"),
    (".config/lazygit/", "vcs", "lazygit"),
    # navigation & search
    (".config/zoxide/", "navigation", "zoxide"),
    (".config/atuin/", "navigation", "atuin"),
    (".config/ripgrep/", "navigation", "ripgrep"),
    # toolchain & packages
    (".config/mise/", "toolchain", "mise"),
    (".config/pacman/", "toolchain", "pacman / AUR"),
    (".Brewfile", "toolchain", "homebrew"),
    # AI agent harnesses
    (".agents/", "agents", "shared skills"),
    (".claude/", "agents", "claude code"),
    (".codex/", "agents", "codex"),
    (".gemini/", "agents", "gemini"),
    (".cline/", "agents", "cline"),
    (".grok/", "agents", "grok"),
    (".grokbot/", "agents", "grokbot"),
    (".pi/", "agents", "pi"),
    (".evotai/", "agents", "evot"),
    (".config/opencode/", "agents", "opencode"),
    # background services
    (".config/systemd/", "services", "user systemd units"),
    (".config/environment.d/", "services", "session environment"),
    # custom executables
    (".local/bin/cline-safety/", "scripts", "cline git interceptor"),
    (".local/bin/", "scripts", "custom executables"),
    # credentials-adjacent
    (".ssh/", "security", "ssh"),
    (".config/1password/", "security", "1password"),
)

CATEGORY_ORDER = (
    "shell",
    "prompt",
    "terminal",
    "editor",
    "desktop",
    "vcs",
    "navigation",
    "toolchain",
    "agents",
    "services",
    "scripts",
    "security",
    "other",
    "hooks",
    "chezmoi",
    "repo",
)

CATEGORY_TITLES = {
    "shell": "Shell",
    "prompt": "Prompt",
    "terminal": "Terminal & multiplexer",
    "editor": "Editors",
    "desktop": "Desktop & window manager",
    "vcs": "Version control",
    "navigation": "Navigation & search",
    "toolchain": "Toolchain & packages",
    "agents": "AI agent harnesses",
    "services": "Background services",
    "scripts": "Custom executables",
    "security": "Credentials & SSH",
    "other": "Other configuration",
    "hooks": "Apply hooks (`run_*`)",
    "chezmoi": "Chezmoi control files",
    "repo": "Repository material (not applied)",
}

# Chezmoi source-name attribute prefixes, longest first so `private_dot_` and
# `encrypted_private_` decode correctly regardless of stacking order.
ATTR_PREFIXES = (
    ("encrypted_", "encrypted"),
    ("private_", "private"),
    ("readonly_", "readonly"),
    ("executable_", "executable"),
    ("symlink_", "symlink"),
    ("create_", "create"),
    ("modify_", "modify"),
    ("remove_", "remove"),
    ("empty_", "empty"),
    ("exact_", "exact"),
)

# Home-relative prefixes that hold runtime state written by other tools rather
# than dotfiles chezmoi renders. A showcase card may legitimately read these,
# so `--audit-showcase` reports them without failing.
EXTERNAL_PREFIXES = (
    ".local/state/",
    ".local/share/omarchy/",
    ".cache/",
)

HOOK_RE = re.compile(
    r"^run_(?P<once>once_|onchange_)?(?P<phase>before_|after_)?(?P<rest>.+?)\.sh(?P<tmpl>\.tmpl)?$"
)


def git_files():
    """Tracked paths, which is the only definition of 'in this repo' we use.

    The two generated artifacts are added unconditionally rather than taken
    from `git ls-files`. They describe themselves, so their tracking state
    would otherwise feed back into their own content: generated before they
    are committed the index omits them, and the very act of committing it then
    makes it stale — which is exactly how this first reached CI. Injecting them
    makes the output identical whether or not they happen to be tracked yet.
    """
    out = subprocess.check_output(["git", "ls-files"], cwd=ROOT)
    tracked = set(out.decode().splitlines())
    tracked.update((INDEX_JSON.name, INDEX_MD.name))
    return sorted(tracked)


def decode_component(component):
    """Strip chezmoi attribute prefixes off one path component.

    Returns (decoded_name, attributes). `literal_` disables decoding for the
    remainder of the component, per chezmoi's own escape hatch.
    """
    attrs = []
    name = component

    if name.startswith("literal_"):
        return name[len("literal_"):], ["literal"]

    changed = True
    while changed:
        changed = False
        for prefix, attr in ATTR_PREFIXES:
            if name.startswith(prefix):
                name = name[len(prefix):]
                attrs.append(attr)
                changed = True
                break

    if name.startswith("dot_"):
        name = "." + name[len("dot_"):]

    return name, attrs


def decode_source(path):
    """Decode a chezmoi source path into a home-relative target path.

    `dot_config/private_Cursor/User/settings.json` →
        (".config/Cursor/User/settings.json", ["private", "template"?...])
    """
    attrs = []
    parts = []
    for component in path.split("/"):
        decoded, component_attrs = decode_component(component)
        attrs.extend(component_attrs)
        parts.append(decoded)

    target = "/".join(parts)

    if target.endswith(".tmpl"):
        target = target[: -len(".tmpl")]
        attrs.append("template")
    if "encrypted" in attrs and target.endswith(".age"):
        target = target[: -len(".age")]

    # Deduplicate while keeping a stable, readable order.
    seen = []
    for attr in attrs:
        if attr not in seen:
            seen.append(attr)
    return target, seen


def categorize(target):
    """Longest-prefix match against CATEGORY_RULES."""
    best = None
    for prefix, category, subsystem in CATEGORY_RULES:
        if target == prefix or target.startswith(prefix):
            if best is None or len(prefix) > len(best[0]):
                best = (prefix, category, subsystem)
    if best is None:
        return "other", None
    return best[1], best[2]


def classify_hook(path):
    """Describe a `run_*` apply hook's trigger semantics and ordering."""
    match = HOOK_RE.match(path)
    if not match:
        return None
    once = (match.group("once") or "").rstrip("_")
    phase = (match.group("phase") or "").rstrip("_")
    rest = match.group("rest")

    order = None
    name = rest
    order_match = re.match(r"^(\d+)-(.*)$", rest)
    if order_match:
        order = int(order_match.group(1))
        name = order_match.group(2)

    trigger = {
        "once": "runs once ever",
        "onchange": "runs when this script's contents change",
        "": "runs after every apply",
    }[once]

    return {
        "trigger": once or "always",
        "trigger_description": trigger,
        "phase": phase or "after",
        "order": order,
        "name": name,
        "template": bool(match.group("tmpl")),
    }


def repo_role(path):
    for prefix, role in REPO_MATERIAL:
        if path == prefix or path.startswith(prefix):
            return role
    return None


def is_chezmoi_control(path):
    return any(path == p or path.startswith(p) for p in CHEZMOI_CONTROL)


def load_showcase_sources(manifest_path):
    """Map live config paths declared by the showcase to their card ids.

    Used only by `--audit-showcase`, never by the generated artifacts. The
    manifest is TypeScript, so this reads the declared `livePath` string
    literals rather than importing or executing anything.
    """
    if manifest_path is None or not manifest_path.is_file():
        return {}

    text = manifest_path.read_text(encoding="utf-8")
    mapping = {}
    current_id = None
    for line in text.splitlines():
        id_match = re.search(r'^\s*id:\s*"([^"]+)"', line)
        if id_match:
            current_id = id_match.group(1)
        for live in re.findall(r'livePath:\s*"([^"]+)"', line):
            if current_id and live.startswith("~/"):
                mapping.setdefault(live[2:], []).append(current_id)
    return mapping


def build(files):
    entries = []
    for path in files:
        role = repo_role(path)
        if role is not None:
            entries.append(
                {
                    "source": path,
                    "kind": "repo",
                    "category": "repo",
                    "role": role,
                }
            )
            continue

        if is_chezmoi_control(path):
            entries.append(
                {
                    "source": path,
                    "kind": "chezmoi",
                    "category": "chezmoi",
                    "role": "Controls how chezmoi renders and applies this tree",
                }
            )
            continue

        hook = classify_hook(path)
        if hook is not None:
            entries.append(
                {
                    "source": path,
                    "kind": "hook",
                    "category": "hooks",
                    "hook": hook,
                }
            )
            continue

        target, attrs = decode_source(path)
        category, subsystem = categorize(target)
        entry = {
            "source": path,
            "target": "~/" + target,
            "kind": "dotfile",
            "category": category,
            "attributes": attrs,
        }
        if subsystem:
            entry["subsystem"] = subsystem
        entries.append(entry)

    entries.sort(key=lambda e: (CATEGORY_ORDER.index(e["category"]), e["source"]))
    return entries


def summarize(entries):
    counts = {}
    for entry in entries:
        counts[entry["category"]] = counts.get(entry["category"], 0) + 1
    return {
        "total": len(entries),
        "by_category": {c: counts[c] for c in CATEGORY_ORDER if c in counts},
    }


def render_json(entries):
    document = {
        "$comment": BANNER,
        "schemaVersion": SCHEMA_VERSION,
        "generator": "docs/generate_index.py",
        "summary": summarize(entries),
        "categories": [
            {"id": c, "title": CATEGORY_TITLES[c]}
            for c in CATEGORY_ORDER
            if any(e["category"] == c for e in entries)
        ],
        "entries": entries,
    }
    return json.dumps(document, indent=2, sort_keys=False) + "\n"


def render_markdown(entries):
    summary = summarize(entries)
    lines = [
        "# Dotfiles Index",
        "",
        f"<!-- {BANNER} -->",
        "",
        "> **Generated file — do not edit.** Produced by `docs/generate_index.py`",
        "> from `git ls-files`. Run `python3 docs/generate_index.py` after adding or",
        "> moving a file; CI fails when this file is stale.",
        "",
        "Machine-readable equivalent: [`INDEX.json`](INDEX.json) — that is the file",
        "agents and the showcase app should read. This page is the same data for humans.",
        "",
        f"**{summary['total']} tracked entries** across "
        f"{len(summary['by_category'])} categories.",
        "",
        "| Category | Entries |",
        "| --- | ---: |",
    ]
    for category, count in summary["by_category"].items():
        anchor = CATEGORY_TITLES[category].lower()
        anchor = re.sub(r"[^a-z0-9 -]", "", anchor).replace(" ", "-")
        lines.append(f"| [{CATEGORY_TITLES[category]}](#{anchor}) | {count} |")
    lines.append("")
    lines.append("---")
    lines.append("")

    for category in CATEGORY_ORDER:
        rows = [e for e in entries if e["category"] == category]
        if not rows:
            continue
        lines.append(f"## {CATEGORY_TITLES[category]}")
        lines.append("")

        if category == "hooks":
            lines.append("| Order | Source | Trigger | Phase |")
            lines.append("| ---: | --- | --- | --- |")
            for entry in sorted(
                rows, key=lambda e: (e["hook"]["order"] is None, e["hook"]["order"] or 0)
            ):
                hook = entry["hook"]
                order = "—" if hook["order"] is None else f"{hook['order']:02d}"
                lines.append(
                    f"| {order} | `{entry['source']}` | "
                    f"{hook['trigger_description']} | {hook['phase']} |"
                )
        elif category in ("repo", "chezmoi"):
            lines.append("| Path | Role |")
            lines.append("| --- | --- |")
            for entry in rows:
                lines.append(f"| `{entry['source']}` | {entry['role']} |")
        else:
            lines.append("| Target | Source | Subsystem | Attributes |")
            lines.append("| --- | --- | --- | --- |")
            for entry in rows:
                attrs = ", ".join(entry["attributes"]) or "—"
                subsystem = entry.get("subsystem") or "—"
                lines.append(
                    f"| `{entry['target']}` | `{entry['source']}` | "
                    f"{subsystem} | {attrs} |"
                )
        lines.append("")

    return "\n".join(lines)


def audit_showcase(entries, manifest_path):
    """Report drift between the showcase's declared live paths and this index.

    The showcase names the host paths it reads (`livePath` in `src/manifest.ts`).
    Each of those should correspond to something this repo actually manages;
    when one does not, either a dotfile moved without the showcase following it
    or the showcase is pointing at a path that was never managed here. Both are
    real drift and both are silent today, so this reports them and fails.
    """
    if not manifest_path.is_file():
        print(
            f"showcase manifest not found at {manifest_path} — "
            "is the submodule checked out? (`git submodule update --init`)",
            file=sys.stderr,
        )
        return 1

    sources = load_showcase_sources(manifest_path)
    if not sources:
        print(f"no livePath declarations found in {manifest_path}", file=sys.stderr)
        return 1

    managed = {e["target"][2:] for e in entries if e["kind"] == "dotfile"}

    matched, external, orphans = [], [], []
    for live, cards in sorted(sources.items()):
        # A declared path may name a directory of managed files (e.g.
        # `~/.agents/skills`) rather than one file, so a prefix match counts.
        if live in managed or any(m.startswith(live.rstrip("/") + "/") for m in managed):
            matched.append((live, cards))
        elif any(live.startswith(prefix) for prefix in EXTERNAL_PREFIXES):
            # Runtime state written by another tool at run time (omarchy's
            # current-theme symlink, caches). These are legitimately outside
            # chezmoi's source tree, so their absence here is not drift.
            external.append((live, cards))
        else:
            orphans.append((live, cards))

    for live, cards in matched:
        print(f"  ok        ~/{live}  ({', '.join(sorted(set(cards)))})")
    for live, cards in external:
        print(f"  external  ~/{live}  ({', '.join(sorted(set(cards)))})")
    for live, cards in orphans:
        print(f"  ORPHAN    ~/{live}  ({', '.join(sorted(set(cards)))})", file=sys.stderr)

    print(f"\n{len(matched)} matched, {len(external)} external (runtime state), "
          f"{len(orphans)} orphaned of {len(sources)} declared live paths")
    if orphans:
        print(
            "Showcase cards declare live paths this repo does not manage. "
            "Update src/manifest.ts, or add the dotfile here.",
            file=sys.stderr,
        )
        return 1
    return 0


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--check",
        action="store_true",
        help="verify the committed artifacts are current; exit 1 if stale",
    )
    parser.add_argument(
        "--audit-showcase",
        nargs="?",
        const=ROOT / "dotfiles-showcase" / "src" / "manifest.ts",
        type=Path,
        metavar="MANIFEST",
        help="report showcase livePath drift instead of writing the index "
             "(defaults to the submodule's src/manifest.ts)",
    )
    args = parser.parse_args()

    entries = build(git_files())

    if args.audit_showcase is not None:
        return audit_showcase(entries, args.audit_showcase)

    want_json = render_json(entries)
    want_md = render_markdown(entries)

    if args.check:
        stale = []
        for path, want in ((INDEX_JSON, want_json), (INDEX_MD, want_md)):
            have = path.read_text(encoding="utf-8") if path.exists() else None
            if have != want:
                stale.append(path.name)
        if stale:
            print(
                "stale: " + ", ".join(stale) + "\n"
                "Run `python3 docs/generate_index.py` and commit the result.",
                file=sys.stderr,
            )
            return 1
        print(f"index up to date ({len(entries)} entries)")
        return 0

    INDEX_JSON.write_text(want_json, encoding="utf-8")
    INDEX_MD.write_text(want_md, encoding="utf-8")
    print(f"wrote INDEX.json + INDEX.md ({len(entries)} entries)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
