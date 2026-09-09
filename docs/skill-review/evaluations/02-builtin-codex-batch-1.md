# Evaluation evidence: builtin-codex batch 1

Ticket scope: HJ-733. Review date: 2026-09-08. This evidence covers exactly four retained variants and does not authorize deployment, installation, candidate execution, or changes to the baseline copies.

| Variant | Disposition | Promotion gate | Recommended routing |
| --- | --- | --- | --- |
| `imagegen/6e733e799e52` | Revise before promotion | Correct the false `gpt-image-2` transparency rejection and add duplicate-output preflight | Optional creative-media pack; built-in task trigger, explicit CLI/API opt-in |
| `openai-docs/1de75a2e0091` | Retain with correction | Make the stale latest-model fallback dated/fail-closed | OpenAI/Codex documentation pack; task-triggered read-only retrieval |
| `plugin-creator/ede23896a590` | Revise before promotion | Emit/validate `defaultPrompt` as an array; separate authoring from install authority; resolve license | Optional plugin-authoring pack; explicit invocation |
| `review-agent/91ab275699ee` | Retain with correction | Include relevant untracked files in the complete-change review | Code-review agent pack; explicit delegated invocation |

## Evidence method

- Read every retained file in all four variant trees, including instructions, references, scripts, metadata, SVG source, PNG assets, and the two retained Apache-2.0 licenses. No license was present for `plugin-creator` or `review-agent`.
- Used the repository inventory as the preservation oracle. Review artifacts are additive; retained candidate bytes were not edited.
- Applied `docs/skill-review/RUBRIC.md` across trigger precision, correctness, authority, progressive disclosure, operational quality, security/privacy, maintenance, and pack/invocation/execution decisions.
- Used current official OpenAI documentation only for claims that are time-sensitive: image model transparency/deprecation, the latest-model family, and plugin manifest packaging/schema.
- Used the indexed code graph at Tier 2 for structural verification of image batch orchestration and plugin validation, then relied on complete retained source reads for exact behavior. Non-code files and literals were checked directly.

## Scenario walkthroughs

### Image generation

1. A user asks for a transparent raster asset with no API-mode request: built-in mode is correctly selected and preserves alpha.
2. A user explicitly requests CLI `gpt-image-2` with transparent PNG: candidate validation incorrectly aborts and recommends deprecated `gpt-image-1.5`; promotion gate fails.
3. Two batch jobs resolve to the same explicit output path: task concurrency allows a check/write race; reliability correction recommended.

### OpenAI documentation

1. A narrow current-model question: exact official topic search/open occurs first; citations and uncertainty rules are appropriate.
2. Live latest-model retrieval succeeds: the dynamic guide/resolver path avoids the pinned fallback.
3. Live retrieval fails: the bundled fallback names GPT-5.6 while current guidance names GPT-6 Astra; stale fallback can mislead in its only active scenario.

### Plugin creation

1. Minimal scaffold generation: generator emits string `defaultPrompt`; candidate reference and official schema require an array; validator accepts the mismatch.
2. Repo-scoped plugin authoring: deterministic scaffold and containment checks are useful when the workspace is authorized.
3. Existing plugin update: cachebuster edit is within an update request, but marketplace registration and install/reinstall are distinct live mutations and require separate authority.

### Review agent

1. Committed branch against a base: merge-base comparison appropriately isolates branch changes.
2. Tracked staged/unstaged changes: ordinary diff inspection covers them.
3. New untracked implementation file: prescribed `git diff` commands omit it despite the “complete diff” claim; coverage gate fails.

## External sources

- Image generation: <https://developers.openai.com/api/docs/guides/image-generation>
- GPT Image 2: <https://developers.openai.com/api/docs/models/gpt-image-2>
- Model catalog: <https://developers.openai.com/api/docs/models/all>
- Latest model: <https://developers.openai.com/api/docs/guides/latest-model>
- Plugin packaging and schema: <https://developers.openai.com/plugins/build/plugins>

## Validation results

- Each of the four exact variants passed its filtered `review.py check`: one selected variant, one contract-valid review, zero invalid or missing reviews, and `allSelectedContractsValid: true`.
- Repository fixture suites passed: 13 inventory tests, 34 review-contract tests, and 2 local-candidate tests. Review JSON parsed successfully, and retained agent YAML was statically parsed without executing candidate code.
- Tier 2 graph verification used project `home-harlan-.local-share-ft-HJ-733-builtin-codex-batch-1`, generation `2026-09-08T21:25:34Z`. The material Python paths had no recorded coverage gap. Licenses and image/SVG assets were outside structural indexing and remained covered by the completed direct-source and visual inspection recorded above.
- `review.py verify-preservation` remains a failing broad historical oracle because it reports repository/head/index changes and unrelated live drift outside these four candidate trees. The four filtered contract checks independently confirm that each retained candidate changed only by additive `REVIEW.md` and `review.json` artifacts.
- Root `INDEX.json`, `INDEX.md`, and the README repository tree were regenerated after adding review artifacts. Their generated-document checks, JSON/YAML parsing, and whitespace checks are completion gates for this worktree.

## Execution boundary

No candidate script, dry-run mode, API request, fetcher, resolver, validator, scaffold, cachebuster, marketplace command, plugin command, install, image generation, or review-agent workflow was executed. Validation is limited to repository-owned review tooling, static parsing, baseline hashes, generated-document checks, and diff hygiene.
