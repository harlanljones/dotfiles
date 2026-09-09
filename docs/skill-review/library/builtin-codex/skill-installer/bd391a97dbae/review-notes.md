# Skill Installer Review Notes

These notes are review evidence, not promoted skill instructions. The frozen
provider files remain unchanged.

## Proposed source changes

- Reconcile `SKILL.md:47` with `SKILL.md:57` and
  `scripts/install-skill-from-github.py:219-223,337-338`: the documented
  implementation always refuses an existing destination, so the skill must not
  promise that insisting will overwrite a preinstalled `.system` skill.
- Preflight every requested source path and destination before copying any member
  of a multi-skill request. `scripts/install-skill-from-github.py:329-345` copies
  sequentially and does not roll back an earlier copy when a later path fails.
- Before a non-curated install, surface repository, ref, paths, destination, and
  the fact that the installer verifies layout and containment but not source
  trust, signatures, semantic correctness, or runtime safety.

## Human decisions

`Q-skill-installer-system-overwrite`: Should the generic installer ever overwrite
a provider-managed `.system` skill?

Recommendation: no. Explain that system skills are provider-managed and route
repair or upgrade requests to a separately authorized provider update mechanism.

`Q-skill-installer-batch-atomicity`: Should a multi-skill request be all-or-none?

Recommendation: yes. Validate all sources and destinations first, stage copies,
and publish them only after the complete batch passes. If atomicity is not
implemented, the user must be told exactly which skills remain installed after a
failure.
