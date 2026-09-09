# Review: builtin-codex `imagegen` (`6e733e799e52`)

## Disposition

**Revise before promotion; retain as a candidate.** The skill has strong built-in-first routing, useful prompt structure, explicit authority boundaries for the CLI fallback, and substantial image-editing expertise. Its CLI guidance and validator currently encode a false model limitation, however, so promoting it would route transparent-image requests away from the current model and toward a deprecated model.

Recommended pack: **optional creative-media pack**, not universal core. Invocation should be task-triggered for raster generation/editing; CLI/API execution should remain explicit opt-in because it requires credentials, network access, cost, and filesystem writes.

## Source-grounded findings

### Promotion blocker: transparent-background model guidance has drifted

The candidate says CLI `gpt-image-2` does not support transparent backgrounds in `SKILL.md:249`, `references/cli.md:82,144,234`, `references/prompting.md:84`, `references/sample-prompts.md:22`, and `scripts/image_gen.py:194-197`. The script actively rejects that combination and tells the user to use `gpt-image-1.5`.

Current official OpenAI image-generation documentation says transparent backgrounds are available in preview for `gpt-image-2` when `background` is `transparent` and the output format is PNG or WebP. The official model catalog also marks GPT Image 1.5 deprecated. The candidate therefore turns current supported behavior into an error and recommends a deprecated fallback. Correct the narrative, examples, and `_validate_model_specific_options` together before promotion.

Official evidence checked 2026-09-08:

- <https://developers.openai.com/api/docs/guides/image-generation>
- <https://developers.openai.com/api/docs/models/gpt-image-2>
- <https://developers.openai.com/api/docs/models/all>

### Execution and reliability observations

- Built-in mode is appropriately preferred and avoids requiring an API key (`SKILL.md:14-27`). The CLI is separated as a confirmed fallback, and destructive overwrites require `--force`.
- Batch generation validates payloads before requests and bounds API concurrency. Graph tracing confirmed `_generate_batch` is the sole candidate caller of `_run_generate_batch`, which fans out through payload validation, output-path planning, retry, decoding, and optional downscaling.
- Concurrent JSONL jobs may specify the same explicit output path. Collision checks and writes occur inside separate tasks, so same-path jobs can race. Reject duplicate resolved output paths before task creation or serialize colliding jobs.
- The chroma-key helper is a useful fallback with threshold checks and alpha diagnostics, but it necessarily estimates a matte; it should not substitute for native alpha when native transparency is available.

## Rubric assessment

- **Trigger precision:** Good. Raster generation/editing is clearly scoped; diagram/document tasks are excluded.
- **Correctness and coherence:** Blocked by the stale `gpt-image-2` transparency rule. Otherwise the two execution modes and references are coherent.
- **Authority and safety:** Good separation of built-in and API/CLI routes; credentials, network, cost, output writes, and overwrite behavior are visible.
- **Progressive disclosure:** Strong. The main skill routes to focused CLI, API, prompting, network, and examples references.
- **Operational quality:** Substantial validation and retry behavior, with the same-output batch race as a residual reliability issue.
- **Security/privacy:** No credential exfiltration behavior found. API inputs and generated outputs leave the local environment when CLI mode is explicitly chosen.
- **Maintenance:** Apache-2.0 license is retained. Model capability assertions need a freshness strategy because they are time-sensitive.

## Recommended revision

1. Permit `gpt-image-2` transparent PNG/WebP output and update every contradictory reference/example.
2. Keep `gpt-image-1.5` only as an explicitly justified legacy option while it remains available; do not present it as the transparency requirement.
3. Add a preflight duplicate-output check for batch jobs.
4. Add static unit coverage for model/background/format validation and duplicate output planning before considering promotion.

## Validation and limitations

All retained text, scripts, metadata, assets, and the Apache-2.0 license were inspected. PNGs were visually inspected and SVGs were read as source. Candidate workflows, API calls, installs, dependency changes, and image generation were not executed. Review tooling verifies retained bytes against the inventory baseline; evaluation here is static and source-grounded.
