# Skill Creator Review Notes

These notes are review evidence, not promoted skill instructions. The frozen
provider files remain unchanged.

## Proposed source changes

- `scripts/quick_validate.py:51-91` checks that `name` and `description` keys
  exist but accepts empty strings. Require both values to be nonempty so the
  validator enforces the entrypoint contract it reports.
- `scripts/init_skill.py:179-218` creates the destination and `SKILL.md` before
  metadata and resource creation can fail. Build in a temporary sibling and
  rename only after every requested file succeeds, or remove the incomplete
  destination on failure.
- Retain the warning at `SKILL.md:103-111`: the YAML generator replaces the
  whole file and therefore must not be used over existing `policy` or
  `dependencies` fields.

## Human decision

`Q-skill-creator-transaction`: Should the bundled initializer guarantee that a
failed initialization leaves no partial skill directory?

Recommendation: yes. Make initialization transactional and fail before exposing
an incomplete skill tree. This keeps retries predictable and prevents a failed
first attempt from triggering the existing-directory refusal on the next attempt.
