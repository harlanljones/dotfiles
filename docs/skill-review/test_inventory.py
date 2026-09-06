#!/usr/bin/env python3
"""Fixture-only controls; no writes to installed skills or configuration."""

import importlib.util
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_file_location("inventory", Path(__file__).with_name("inventory.py"))
inventory = importlib.util.module_from_spec(spec)
spec.loader.exec_module(inventory)


class InventoryTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="skill-inventory-")
        self.addCleanup(self.tmp.cleanup)
        self.base = Path(self.tmp.name)
        self.source = self.base / "source"
        self.source.mkdir()
        (self.source / "SKILL.md").write_text("---\nname: fixture\n---\nRead refs.md.\n")
        (self.source / "refs.md").write_text("First reference.\n")

    def variant(self):
        return {"tree": inventory.tree(self.source), "candidatePath": "library/test/fixture/abc123",
                "locations": [{"resolvedPath": str(self.source)}], "licenses": []}

    def test_same_entrypoint_different_references_are_variants(self):
        first = inventory.tree(self.source)
        skill_hash = inventory.file_hash(self.source / "SKILL.md")
        (self.source / "refs.md").write_text("Second reference.\n")
        self.assertEqual(skill_hash, inventory.file_hash(self.source / "SKILL.md"))
        self.assertNotEqual(first["sha256"], inventory.tree(self.source)["sha256"])

    def test_live_verification_rejects_changed_fixture_bytes(self):
        baseline = {}
        inventory.tree(self.source, baseline)
        frozen = {"baseline": baseline, "gitBaseline": {}, "repo": str(self.base)}
        with patch.object(inventory, "git_baseline", return_value={}):
            inventory.verify_live(frozen)
            (self.source / "refs.md").write_text("Changed reference.\n")
            with self.assertRaisesRegex(ValueError, "Baseline changed"):
                inventory.verify_live(frozen)

    def test_root_dereference_internal_links_and_no_live_escape(self):
        (self.source / "relative.md").symlink_to("refs.md")
        (self.source / "absolute.md").symlink_to(self.source / "refs.md")
        root_link = self.base / "installed"
        root_link.symlink_to(self.source)
        self.assertEqual(inventory.tree(root_link), inventory.tree(self.source))
        variant = self.variant()
        out = self.base / "out"
        out.mkdir()
        with patch.object(inventory, "verify_live"):
            inventory.materialize({"variants": [variant]}, out)
        candidate = out / variant["candidatePath"]
        for name in ("relative.md", "absolute.md"):
            link = candidate / name
            self.assertTrue(link.is_symlink())
            self.assertEqual(link.readlink(), Path("refs.md"))
            self.assertTrue(link.resolve().is_relative_to(candidate))
        inventory.check_candidate(candidate, variant)

    def test_reject_external_and_broken_support_links(self):
        external = self.base / "outside.md"
        external.write_text("Outside.\n")
        link = self.source / "escape.md"
        link.symlink_to(external)
        with self.assertRaisesRegex(ValueError, "escapes"):
            inventory.tree(self.source)
        link.unlink()
        link.symlink_to("missing.md")
        with self.assertRaises(FileNotFoundError):
            inventory.tree(self.source)

    def test_materialization_refuses_edited_candidate_and_parent_links(self):
        variant = self.variant()
        out = self.base / "out"
        out.mkdir()
        with patch.object(inventory, "verify_live"):
            inventory.materialize({"variants": [variant]}, out)
            inventory.materialize({"variants": [variant]}, out)
            candidate = out / variant["candidatePath"]
            (candidate / "refs.md").write_text("Reviewed candidate.\n")
            with self.assertRaisesRegex(ValueError, "refusing overwrite"):
                inventory.materialize({"variants": [variant]}, out)
            self.assertEqual((candidate / "refs.md").read_text(), "Reviewed candidate.\n")
        evil = self.base / "evil"
        evil.mkdir()
        (evil / "library").symlink_to(self.source)
        with self.assertRaisesRegex(ValueError, "may not be a link"):
            inventory.candidate_path(evil, variant)

    def test_secret_controls_do_not_expose_content(self):
        secret = b"-----BEGIN " + b"OPENSSH PRIVATE KEY-----"
        with self.assertRaisesRegex(ValueError, "not displayed"):
            inventory.scan_secret(Path("data.txt"), secret)
        with self.assertRaisesRegex(ValueError, "private material"):
            inventory.scan_secret(Path("identity.pem"), b"private")
        (self.source / ".env").write_bytes(secret)
        (self.source / "node_modules").mkdir()
        (self.source / "node_modules/fixture.txt").write_text("Dependency")
        excluded = []
        result = inventory.tree(self.source, exclusions=excluded)
        self.assertEqual(len(excluded), 2)
        self.assertFalse(any(e["path"] == ".env" for e in result["entries"]))

    def test_baseline_rejects_link_string_and_membership_change(self):
        link = self.source / "ref-link"
        link.symlink_to("refs.md")
        baseline = {}
        inventory.tree(self.source, baseline)
        frozen = {"baseline": baseline, "gitBaseline": {}, "repo": str(self.base)}
        with patch.object(inventory, "git_baseline", return_value={}):
            inventory.verify_live(frozen)
            link.unlink()
            link.symlink_to("./refs.md")
            with self.assertRaisesRegex(ValueError, "Baseline changed"):
                inventory.verify_live(frozen)
            link.unlink()
            link.symlink_to("refs.md")
            inventory.verify_live(frozen)
            (self.source / "new-file.md").write_text("New discovery member.\n")
            with self.assertRaisesRegex(ValueError, "Baseline changed"):
                inventory.verify_live(frozen)

    def test_worktree_verification_is_separate_and_rejects_drift(self):
        frozen = {"baseline": {}, "gitBaseline": {"indexSha256": "before"}, "repo": str(self.base)}
        with patch.object(inventory, "git_baseline", return_value={"indexSha256": "before"}):
            inventory.verify_worktree(frozen)
        with patch.object(inventory, "git_baseline", return_value={"indexSha256": "after"}):
            inventory.verify_live(frozen)
            with self.assertRaisesRegex(ValueError, "worktree/index"):
                inventory.verify_worktree(frozen)

    def test_candidate_check_rejects_added_excluded_content(self):
        variant = self.variant()
        out = self.base / "out"
        out.mkdir()
        with patch.object(inventory, "verify_live"):
            inventory.materialize({"variants": [variant]}, out)
        candidate = out / variant["candidatePath"]
        (candidate / ".env").write_text("NEW=private\n")
        with self.assertRaisesRegex(ValueError, "refusing overwrite"):
            inventory.check_candidate(candidate, variant)

    def test_unknown_candidate_directory_is_rejected(self):
        variant = self.variant()
        out = self.base / "out"
        (out / "library/unknown").mkdir(parents=True)
        with self.assertRaisesRegex(ValueError, "Unexpected candidate directory"):
            inventory.check_library_layout({"variants": [variant]}, out)

    def test_supporting_nested_skills_retained_but_not_targets(self):
        nested = self.source / "examples/fixture"
        nested.mkdir(parents=True)
        (nested / "SKILL.md").write_text("Nested fixture.\n")
        exclusions = []
        result = inventory.tree(self.source, exclusions=exclusions)
        self.assertTrue(any(e["path"] == "examples/fixture/SKILL.md" for e in result["entries"]))
        self.assertEqual(exclusions[0]["scope"], "independent-target-only")

    def test_declared_plugin_path_normalization(self):
        self.assertEqual(inventory.declared_path(self.base, "plugins/neon/skills/foo/SKILL.md", "plugins/neon"),
                         self.base / "skills/foo/SKILL.md")
        with self.assertRaisesRegex(ValueError, "Unsafe"):
            inventory.declared_path(self.base, "../live/SKILL.md", None)

    def test_inherited_license_and_assets_preserved(self):
        (self.source / "asset.bin").write_bytes(bytes(range(256)))
        license_path = self.base / "LICENSE"
        license_path.write_text("Fixture license.\n")
        variant = self.variant()
        variant["licenses"] = [{"path": str(license_path), "sha256": inventory.file_hash(license_path),
                                "bytes": license_path.stat().st_size, "inTree": False}]
        out = self.base / "out"
        out.mkdir()
        with patch.object(inventory, "verify_live"):
            inventory.materialize({"variants": [variant]}, out)
        candidate = out / variant["candidatePath"]
        inventory.check_candidate(candidate, variant)
        self.assertEqual((candidate / "asset.bin").read_bytes(), bytes(range(256)))
        self.assertEqual(next((candidate / "_inventory-licenses").iterdir()).read_text(), "Fixture license.\n")


if __name__ == "__main__":
    unittest.main()
