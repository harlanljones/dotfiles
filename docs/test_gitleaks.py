#!/usr/bin/env python3
"""Check narrow exceptions with the same gitleaks binary used by CI."""

import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parent.parent
CLOUDFLARE = "docs/skill-review/library/pack-cloudflare/cloudflare/cb252c0fc395"
VARIANT = "auth:" + "9b19a2160019a684233595ca0814fd7ad548b616a0093078ec85334228a8e77a"
# Synthetic, assembled so the fixture source is not itself a credential finding.
SYNTHETIC = "A7b9C2d4E6f8G1h3" + "J5k7L9m2N4p6Q8r1"
EXAMPLES = {
    "docs/skill-review/inventory.json": f'  "id": "{VARIANT}",\n',
    "docs/skill-review/INDEX.json": f'  "variant": "{VARIANT}"\n',
    f"{CLOUDFLARE}/references/bindings/patterns.md":
        '{ "vars": { "API_KEY": "' + 'sk_live_abc123' + '" } }\n',
    "docs/skill-review/library/pack-cloudflare/workers-best-practices/703a2d204941/references/rules.md":
        '"API_KEY": "' + 'sk-live-abc123...' + '"\n',
    "docs/skill-review/library/plugin-cursor-grafana-assistant/grafana-assistant-cli/926d52c7e602/SKILL.md":
        "token: glsa_abcd1234\n",
    f"{CLOUDFLARE}/references/argo-smart-routing/api.md":
        'curl' + ' -X GET "https://api.cloudflare.com/client/v4/zones/{zone_id}/argo/smart_routing" \\\n'
        '  -H "Authorization: Bearer ' + 'YOUR_API_TOKEN' + '"\n',
}


class SecretScanTests(unittest.TestCase):
    def scan(self, files):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            for name, content in files.items():
                path = root / name
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(content)
            report = root / "report.json"
            result = subprocess.run(
                [os.environ.get("GITLEAKS_BIN", "gitleaks"), "detect",
                 "--no-git", "--source", ".", "--config", str(ROOT / ".gitleaks.toml"),
                 "--no-banner", "--redact", "--report-path", str(report)],
                cwd=root, capture_output=True, text=True,
            )
            self.assertIn(result.returncode, (0, 1), result.stderr)
            self.assertTrue(report.is_file(), result.stderr)
            findings = json.loads(report.read_text())
            self.assertEqual(result.returncode, int(bool(findings)), result.stderr)
            return findings

    def test_documented_examples_allowed(self):
        self.assertEqual(self.scan(EXAMPLES), [])

    def test_credentials_in_same_files_still_detected(self):
        files = {name: text + f'api_key = "{SYNTHETIC}"\n' for name, text in EXAMPLES.items()}
        findings = self.scan(files)
        self.assertEqual({f["File"] for f in findings}, set(files))
        self.assertTrue(all(f["Secret"] == "REDACTED" for f in findings))

    def test_exceptions_require_exact_value_and_path(self):
        files = {
            "outside.md": EXAMPLES[f"{CLOUDFLARE}/references/bindings/patterns.md"],
            f"{CLOUDFLARE}/references/argo-smart-routing/api.md":
                EXAMPLES[f"{CLOUDFLARE}/references/argo-smart-routing/api.md"].replace("YOUR_API_TOKEN", SYNTHETIC),
            "docs/skill-review/inventory.json": f'  "id": "auth:{SYNTHETIC}"\n',
            "docs/skill-review/INDEX.json":
                f'  "id": "{VARIANT}", "api_key": "{SYNTHETIC}"\n',
        }
        findings = self.scan(files)
        self.assertEqual({f["File"] for f in findings}, set(files))


if __name__ == "__main__":
    unittest.main()
