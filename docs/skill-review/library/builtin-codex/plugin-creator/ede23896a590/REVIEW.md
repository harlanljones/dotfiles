# Review: builtin-codex `plugin-creator` (`ede23896a590`)

## Disposition

**Revise before promotion; retain as a candidate.** The skill has a useful deterministic scaffold, careful identifier/path handling, marketplace preservation rules, and a substantial validator. The default generated manifest does not match either its own reference or the current official schema, and the update path blurs plugin editing with live installation.

Recommended pack: **optional Codex plugin-authoring pack**. Invocation should be explicit because normal operation writes plugin trees and marketplace catalogs and may proceed to installation. Execution should remain in-session within an authorized workspace; personal marketplace writes and install/reinstall commands require separate explicit authority.

## Source-grounded findings

### Promotion blocker: generated `defaultPrompt` has the wrong type

`scripts/create_basic_plugin.py:71` emits `interface.defaultPrompt` as a string. The candidate's own schema reference specifies an array of strings (`references/plugin-json-spec.md:31,102`), as does current official OpenAI plugin documentation. `scripts/validate_plugin.py:182-185` checks only whether the field exists and never validates its type, so the provided validator accepts the malformed value. This contradicts the skill's promise of “valid manifest defaults” (`SKILL.md:3,90`).

Change the generator to emit an array and make the validator require a non-empty array of non-empty strings. Add a fixture that validates the default scaffold against the documented compatibility schema.

Official evidence checked 2026-09-08:

- <https://developers.openai.com/plugins/build/plugins>

The official page also confirms that `.codex-plugin/plugin.json` remains a supported compatibility scaffold, while portable root `plugin.json` is now preferred for new packages. The candidate should state this positioning instead of presenting the compatibility layout as the only required structure.

### Authority correction: update is not install authority

The skill points updates to a cachebuster-and-reinstall flow (`SKILL.md:71-81,207-215`; `references/installing-and-updating.md:39-87`). Editing an existing plugin does not inherently authorize `codex plugin marketplace add` or `codex plugin add`, both of which change live Codex configuration/install state. Require a separate confirmation before marketplace registration or install/reinstall. Keep repo-scoped generation inside the user-authorized workspace by default; do not default to `~/plugins` or `~/.agents/plugins/marketplace.json` unless the user explicitly selects personal scope.

### Additional observations

- Identifier normalization, relative-path containment checks, unknown-field rejection, TODO rejection, optional asset validation, and preservation of existing marketplace display names are good safeguards.
- The official compatibility scaffold deliberately declares `skills: "./skills/"` even before skill folders are populated, so that behavior is not treated as a defect; the handoff should still say the plugin is not skills-ready until a valid skill exists.
- No license file was retained or discovered for this candidate. Distribution permission remains unknown and must be resolved before promotion beyond candidate-only evidence.

## Rubric assessment

- **Trigger precision:** Clear authoring task, but explicit invocation is appropriate due to writes and possible installation.
- **Correctness and coherence:** Blocked by the generator/reference/validator disagreement on `defaultPrompt`; compatibility versus portable layout also needs updating.
- **Authority and safety:** Overwrite controls are present. Personal config writes and installation need separate authorization gates.
- **Progressive disclosure:** Good separation of the main workflow, schema reference, and install/update reference.
- **Operational quality:** Deterministic scripts and broad static validation are strengths; the validator's missing type check undermines the default path.
- **Security/privacy:** Path containment and HTTPS checks are useful. Live config and installation scope must remain explicit.
- **Maintenance:** No license discovered; schema drift should be managed against a versioned official contract.

## Recommended revision

1. Emit and validate `defaultPrompt` as a non-empty array of non-empty strings.
2. Explain that the generated `.codex-plugin` layout is a supported compatibility format and offer the portable root manifest for new packages.
3. Split authoring, marketplace-file mutation, marketplace registration, and plugin installation into independently authorized stages.
4. Add static fixtures for the minimal scaffold, every optional component, existing marketplace preservation, malformed prompt types, and path escapes.
5. Resolve licensing before promotion or redistribution.

## Validation and limitations

Every retained instruction, reference, script, metadata file, and asset was inspected; PNGs were visually inspected and SVG source was read. No license was present. Candidate scripts, scaffolds, marketplace changes, plugin commands, installation, or validation workflows were not executed. Graph tracing confirmed the validator entry point delegates to manifest loading, TODO rejection, and shape validation; conclusions use the retained source as ground truth.
