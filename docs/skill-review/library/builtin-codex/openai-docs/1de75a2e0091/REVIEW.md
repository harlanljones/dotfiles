# Review: builtin-codex `openai-docs` (`1de75a2e0091`)

## Disposition

**Retain with a fallback freshness correction; candidate only until corrected.** The skill's official-source-first workflow, narrow domain allowlist, model-preservation rules, citation discipline, and separation of lookup from implementation are strong. Its normal path resolves current documentation dynamically. The bundled “latest model” fallback is already stale, however, precisely where it is meant to operate when live lookup fails.

Recommended pack: **OpenAI/Codex documentation pack** for environments that answer OpenAI product, API, model, or Codex questions. Invocation should be task-triggered. Execution should normally stay in-session and read-only; bounded parallel retrieval is reasonable only for genuinely broad synthesis.

## Source-grounded findings

### Required correction: stale latest-model fallback

`SKILL.md:34-36`, `references/model-selection.md:5-12`, and `references/model-migration.md:8-30` correctly require current official retrieval first and disclose fallback use. `scripts/resolve-latest-model-info.cjs` likewise fetches and parses the live latest-model guide.

But `references/latest-model.md:5-14` identifies GPT-5.6 as the latest family. Current official guidance identifies GPT-6 Astra as the latest model. Although the file labels itself non-authoritative, stale content becomes actionable only when the live source is unavailable, so the warning does not prevent an incorrect fallback recommendation. Replace this with a dated snapshot that refuses to claim “latest” after its review date, or make failure to retrieve current guidance an explicit uncertainty outcome instead of recommending a pinned family.

Official evidence checked 2026-09-08:

- <https://developers.openai.com/api/docs/guides/latest-model>
- <https://developers.openai.com/api/docs/models/gpt-5.6-terra>

### Strengths and residual risks

- The skill searches exact official topics first, opens actual pages, restricts sources to official OpenAI domains, and distinguishes documented facts from inference.
- Explicitly requested models are preserved rather than silently upgraded. Implementation work requires separate user authority.
- The manual and resolver helpers are scoped retrieval/parsing tools. Their failures are surfaced rather than silently converted to fabricated guidance.
- Model-specific bundled migration and prompting references are detailed but inherently perishable. They should carry source/review dates and be reverified before use, as the skill already directs.
- The resolver depends on a Node.js 18+ runtime and live network access. The shell wrapper reports absence clearly; no dependency installation is attempted.

## Rubric assessment

- **Trigger precision:** Strong for OpenAI/Codex documentation, model selection, and migration questions.
- **Correctness and coherence:** The live-source route is coherent; the pinned latest fallback has demonstrably drifted.
- **Authority and safety:** Read-only retrieval is separated from repository changes. No write, apply, publish, or model migration is implied by a documentation question.
- **Progressive disclosure:** Strong routing among official-docs, self-knowledge, migration, selection, prompting, and diagnostics references.
- **Operational quality:** Retrieval and parser failure modes are explicit. Current-source availability remains a necessary limitation.
- **Security/privacy:** Official domains are narrowly allowlisted; no secrets are requested or persisted.
- **Maintenance:** Apache-2.0 license is retained. Time-sensitive snapshots need explicit expiry/review metadata.

## Recommended revision

1. Remove the undated “latest” recommendation from `references/latest-model.md`, or attach an expiry and fail closed after it.
2. Add source and last-verified dates to bundled model-specific guidance.
3. Keep the current official-source-first and separate-implementation-authority rules unchanged.
4. Add parser fixtures for changed/missing `latestModelInfo` formats without performing live requests in repository CI.

## Validation and limitations

Every retained instruction, reference, script, metadata file, asset, and Apache-2.0 license was inspected. The installed and retained `SKILL.md` copies were byte-compared. Official documentation was used only to verify time-sensitive claims. Candidate fetchers and resolvers were not executed, and no network or repository mutation was delegated to them.
