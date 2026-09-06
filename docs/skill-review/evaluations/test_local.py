#!/usr/bin/env python3
"""Validate six local candidate documents; execute only the isolated Bash loader."""

import json
from pathlib import Path
import re
import subprocess
import tempfile
import unittest

import yaml


ROOT = Path(__file__).resolve().parents[1]


class LocalCandidates(unittest.TestCase):
    def test_metadata_questions_and_supporting_links(self):
        variants = [v for v in json.loads((ROOT / "inventory.json").read_text())["variants"]
                    if v["source"] == "local-tracked"]
        self.assertEqual(len(variants), 6)
        question_ids = []
        for variant in variants:
            root = ROOT / variant["candidatePath"]
            body = (root / "SKILL.md").read_text()
            metadata = yaml.safe_load(body.split("---", 2)[1])
            self.assertEqual(metadata["name"], variant["identity"])
            self.assertTrue(0 < len(metadata["description"]) <= 1024)
            for target in re.findall(r"\]\(([^)]+)\)", body):
                if "://" not in target and not target.startswith("#"):
                    self.assertTrue((root / target.split("#")[0]).is_file(), target)
            if metadata["name"] == "frontier-sweep":
                self.assertIs(metadata["disable-model-invocation"], True)
            for agent in root.glob("agents/*.yaml"):
                self.assertIsInstance(yaml.safe_load(agent.read_text())["interface"], dict)
            review = json.loads((root / "review.json").read_text())
            question_ids.extend(q["id"] for q in review["questions"])
        self.assertEqual(len(question_ids), 8)
        self.assertEqual(len(question_ids), len(set(question_ids)))

    def test_loader_with_synthetic_credentials_only(self):
        skill = ROOT / "library/local-tracked/linear-agent-tracking/7b9526d1ffaa/SKILL.md"
        block = re.search(r"```bash\n(.*?)\n```", skill.read_text(), re.S).group(1)
        function = block.rsplit("\nload_linear_toml", 1)[0]
        with tempfile.TemporaryDirectory(prefix="local-skill-loader-") as folder:
            root = Path(folder)
            cases = [("valid", 'LINEAR_API_KEY = "fixture-only"\n', True),
                     ("empty", 'LINEAR_API_KEY = ""\n', False),
                     ("unmatched", 'OTHER = "fixture-only"\n', False),
                     ("duplicate", 'LINEAR_API_KEY = "one"\nLINEAR_API_KEY = "two"\n', False),
                     ("missing", None, False)]
            for name, contents, expected in cases:
                path = root / name
                if contents is not None:
                    path.write_text(contents)
                command = function + '\nload_linear_toml "$1"'
                if expected:
                    command += '\n[[ "$LINEAR_API_KEY" == "fixture-only" ]]'
                result = subprocess.run(["bash", "--noprofile", "--norc", "-c", command, "fixture", str(path)],
                                        env={"PATH": "/usr/bin:/bin", "HOME": folder},
                                        capture_output=True, text=True, timeout=5)
                self.assertEqual(result.returncode == 0, expected, name)
                self.assertEqual(result.stdout, "", name)
                self.assertNotIn("fixture-only", result.stderr)


if __name__ == "__main__":
    unittest.main()
