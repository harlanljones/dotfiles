#!/usr/bin/env python3
"""Smoke-test the dual-shell module loader (dot_bashrc + dot_zshrc).

The rc files source ~/.config/shell/*.sh via a glob, so the load order is the
LEXICAL order of the filenames -- not the numeric order of their prefixes.
These tests pin the invariants the loader depends on:

1. every module has a numeric prefix, and prefixes are unique;
2. lexical filename order equals numeric prefix order (catches an unpadded
   prefix like `10-x.sh` silently sorting before `5-y.sh`);
3. both rc loaders glob the same directory with the same pattern;
4. every module parses under bash -n and zsh -n (zsh skipped when absent).

Run: python3 docs/test_shell_modules.py -v
"""

import os
import re
import shutil
import subprocess
import sys
import unittest
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
SHELL_DIR = REPO / "dot_config" / "shell"
LOADERS = (REPO / "dot_bashrc", REPO / "dot_zshrc")

# The exact glob both loaders must use to pick up the modules.
GLOB_RE = re.compile(r'\$\{XDG_CONFIG_HOME:-\$HOME/\.config\}"?/shell/\*\.sh(?:\(N\))?')
PREFIX_RE = re.compile(r"^(\d+)-")


def modules():
    return sorted(SHELL_DIR.glob("*.sh"))


class TestShellModules(unittest.TestCase):
    def test_modules_exist(self):
        self.assertTrue(modules(), "no *.sh modules found in dot_config/shell/")

    def test_numeric_prefixes_present_and_unique(self):
        seen = {}
        for m in modules():
            match = PREFIX_RE.match(m.name)
            self.assertIsNotNone(match, f"{m.name}: missing numeric prefix")
            prefix = int(match.group(1))
            self.assertNotIn(prefix, seen, f"{m.name}: duplicate prefix {prefix} (also {seen.get(prefix)})")
            seen[prefix] = m.name

    def test_lexical_order_equals_numeric_order(self):
        # The loaders source in glob (lexical) order; this fails if a prefix
        # is added with a different digit count than the neighbours (e.g. a
        # bare `5-` between `40-` and `50-` would load last, not fifth).
        lexical = [m.name for m in modules()]
        numeric = sorted(
            lexical,
            key=lambda n: int(PREFIX_RE.match(n).group(1)),  # noqa: test guarantees a match
        )
        self.assertEqual(lexical, numeric,
                         "lexical filename order != numeric prefix order; "
                         "zero-pad the new prefix to match its neighbours")

    def test_both_loaders_glob_the_shell_dir(self):
        for loader in LOADERS:
            text = loader.read_text()
            self.assertRegex(text, GLOB_RE,
                             f"{loader.name}: does not glob ~/.config/shell/*.sh")

    def test_modules_parse_under_both_shells(self):
        shells = {"bash": shutil.which("bash")}
        if zsh := shutil.which("zsh"):
            shells["zsh"] = zsh
        for name, shell in shells.items():
            assert shell is not None
            for m in modules():
                with self.subTest(shell=name, module=m.name):
                    subprocess.run([shell, "-n", str(m)], check=True)


if __name__ == "__main__":
    unittest.main(verbosity=2)
