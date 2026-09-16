#!/usr/bin/env python3
"""Lint .gitignore vs .chezmoiignore.tmpl for contradictory intent.

The two files are kept in sync manually (AGENTS.md §6): .gitignore decides
what git tracks, .chezmoiignore decides what chezmoi applies. Both use
gitignore-style patterns, including `!` negations, so the same path can end
up ignored in one file and explicitly re-included in the other — an
ambiguity that causes either "why is this not applied?" or "why is this
applied but untracked?" confusion. This lints the interaction:

  1. IGNORE-vs-NEGATE: a path family ignored by one file while negated by
     the other (the real contradiction this lint exists for).
  2. SELF-CONTRADICTION: the same path both ignored and negated inside
     .chezmoiignore's static section (chezmoi's own matcher resolves these
     last-match-wins, but the intent is invisible to readers).

Template directives ({{- if }} …) are stripped, so machine-conditional
entries are linted as if unconditional; their guards are checked by the
CI smoke-apply legs instead.

Run: python3 docs/check_ignore_consistency.py
Exit 0 = consistent, 1 = contradictions found.
"""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
GITIGNORE = ROOT / ".gitignore"
CHEZMOIIGNORE = ROOT / ".chezmoiignore.tmpl"

TEMPLATE_DIRECTIVE = re.compile(r"^\s*\{\{.*\}\}\s*$")
COMMENT = re.compile(r"^\s*(#|$)")


def patterns(path, strip_templates):
    out = []
    lint_ok = set()
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.rstrip("\n")
        if strip_templates and TEMPLATE_DIRECTIVE.match(line):
            continue
        stripped = line.strip()
        if stripped.startswith("# lint-ok:"):
            # Documented exception: `<family> (<why>)` — suppresses the
            # self-contradiction rule for that family.
            lint_ok.add(family(stripped[len("# lint-ok:"):].split("(")[0].strip()))
            continue
        if COMMENT.match(stripped):
            continue
        if not stripped:
            continue
        negated = stripped.startswith("!")
        pattern = stripped[1:] if negated else stripped
        out.append((pattern, negated))
    return out, lint_ok


def family(pattern):
    """Bucket patterns so `foo/` and `foo/**` and `foo` compare equal."""
    p = pattern.strip("/")
    if p.endswith("/**"):
        p = p[: -len("/**")]
    return p or pattern


def intent(patterns_list):
    """family -> {'ignored', 'negated'} union of per-pattern stances."""
    result = {}
    for pattern, negated in patterns_list:
        result.setdefault(family(pattern), set()).add(
            "negated" if negated else "ignored"
        )
    return result


def main():
    git_list, _ = patterns(GITIGNORE, strip_templates=False)
    chez_list, chez_lint_ok = patterns(CHEZMOIIGNORE, strip_templates=True)
    git = intent(git_list)
    chez = intent(chez_list)

    errors = []

    for fam, stances in chez.items():
        if fam in chez_lint_ok:
            continue
        if "ignored" in stances and "negated" in stances:
            errors.append(
                f".chezmoiignore both ignores and negates '{fam}' "
                "(last-match-wins hides the intent). If this is the "
                "parent-dir un-ignore idiom, document it with a "
                "`# lint-ok: <family> (<reason>)` comment line."
            )

    for fam, git_stances in git.items():
        chez_stances = chez.get(fam)
        if chez_stances is None:
            continue
        if "ignored" in git_stances and "negated" in chez_stances:
            errors.append(
                f"'{fam}': .gitignore ignores it but .chezmoiignore negates it "
                "(tracked-by-git vs applied-by-chezmoi conflict)"
            )
        if "negated" in git_stances and "ignored" in chez_stances:
            errors.append(
                f"'{fam}': .gitignore negates it (tracked) but .chezmoiignore "
                "ignores it (never applied) — tracked material that cannot deploy"
            )

    if errors:
        for error in errors:
            print(f"IGNORE-CONSISTENCY: {error}", file=sys.stderr)
        print(
            "Fix the ignore files so intent matches across .gitignore and "
            ".chezmoiignore.tmpl.",
            file=sys.stderr,
        )
        return 1
    print(
        f"ignore files consistent ({len(git)} gitignore families, "
        f"{len(chez)} chezmoiignore families)"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
