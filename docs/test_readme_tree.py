#!/usr/bin/env python3
"""Regression tests for the README repository-structure tree.

docs/generate_readme_tree.py condenses homogeneous subtrees (theme ports,
wallpaper sets, hermes skills) and file families (run_* hooks, per-agent
usage collectors, omarchy units) into one summary line each so the tree
stays readable instead of enumerating hundreds of near-identical rows.
These tests pin that contract:

1. every COLLAPSED / FAMILY_COLLAPSE entry still matches tracked files
   (catches a stale prefix after a subtree moves or is deleted);
2. the rendered tree contains the summary lines with accurate counts, while
   none of the collapsed members leak back in as expanded rows;
3. every top-level run_* hook is captured by the summary (a hook that misses
   the capture filter would render as its own row, duplicating the summary).

Run: python3 docs/test_readme_tree.py -v
"""

import subprocess
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import generate_readme_tree as tree

REPO = Path(__file__).resolve().parent.parent


def ls_files():
    out = subprocess.check_output(["git", "ls-files"], cwd=REPO)
    return out.decode().splitlines()


def visible(files):
    return [
        p for p in files
        if not any(p == s or p.startswith(s) for s in tree.SKIP)
    ]


def render():
    return "\n".join(tree.render_children(tree.build(tree.tracked(None)), ""))


class TestTreeCondensing(unittest.TestCase):
    def test_collapsed_prefixes_match_tracked_files(self):
        files = visible(ls_files())
        for prefix in tree.COLLAPSED:
            hits = [p for p in files
                    if p == prefix or p.startswith(prefix + "/")]
            self.assertTrue(hits, f"COLLAPSED[{prefix!r}] matches no tracked files")

    def test_family_prefixes_match_multiple_files(self):
        files = visible(ls_files())
        for head, (leaf_prefix, _note) in tree.FAMILY_COLLAPSE.items():
            hits = [p for p in files
                    if p.rpartition("/")[0] == head
                    and p.rpartition("/")[2].startswith(leaf_prefix)]
            self.assertGreaterEqual(
                len(hits), 2,
                f"FAMILY_COLLAPSE[{head!r}] matches {len(hits)} files; "
                "a family of one should render expanded instead")

    def test_run_hooks_all_captured(self):
        files = visible(ls_files())
        hooks = [p for p in files
                 if "/" not in p and p.startswith("run_")
                 and p.endswith(".sh.tmpl")]
        self.assertTrue(hooks, "no top-level run_*.sh.tmpl hooks found")
        body = render()
        self.assertIn(tree.RUN_HOOKS_NOTE.format(n=len(hooks)), body)
        for hook in hooks:
            self.assertNotIn(hook, body, f"{hook} rendered expanded alongside the summary")

    def test_summaries_accurate_and_members_hidden(self):
        files = visible(ls_files())
        body = render()
        for prefix, note in tree.COLLAPSED.items():
            hits = [p for p in files
                    if p == prefix or p.startswith(prefix + "/")]
            groups = {p[len(prefix) + 1:].split("/")[0] for p in hits}
            self.assertIn(note.format(n=len(hits), groups=len(groups)), body)
        for head, (leaf_prefix, note) in tree.FAMILY_COLLAPSE.items():
            hits = [p for p in files
                    if p.rpartition("/")[0] == head
                    and p.rpartition("/")[2].startswith(leaf_prefix)]
            self.assertIn(note.format(n=len(hits)), body)
            for member in hits:
                self.assertNotIn(member.rpartition("/")[2], body)
        # Spot-check collapsed members and kept neighbours.
        for absent in ("omarchy-tokyo-night", "tokyonight-storm",
                       "executable_omarchy-agent-usage-cline",
                       "omarchy-cline-usage-scrape.service"):
            self.assertNotIn(absent, body, f"{absent} leaked into the tree")
        for present in ("machine-theme-name.tmpl",
                        "executable_omarchy-agent.tmpl",
                        "herdr-outpost-relay.service"):
            self.assertIn(present, body, f"{present} went missing from the tree")


if __name__ == "__main__":
    unittest.main()
