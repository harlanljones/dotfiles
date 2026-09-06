# Review Questions

Recommendations are not accepted policy. Invalid contracts are labelled.

Contract errors for library/builtin-codex/imagegen/6e733e799e52: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/builtin-codex/openai-docs/1de75a2e0091: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/builtin-codex/plugin-creator/ede23896a590: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/builtin-codex/review-agent/91ab275699ee: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/builtin-codex/skill-creator/5be1693bd421: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/builtin-codex/skill-installer/bd391a97dbae: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/harness-claude-skills/codebase-memory/c4002c91abe2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/harness-claude-skills/impeccable/6c5d5e55dd40: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/harness-claude-skills/mixture-of-agents/b6883206a8b5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/harness-config-opencode-skills/impeccable/82d09480e480: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/harness-gemini-config-skills/impeccable/dda62b499a21: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/harness-gemini-skills/impeccable/ea77c0b5c398: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/harness-pi-agent-skills/impeccable/fa8118279b98: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

## Q-dots-apply

Candidate: library/local-tracked/dots/d8d88aa134da (contract-valid)

Question: Should source edits imply apply authority?

Recommendation: Keep source edit and live apply separately authorized.

Rationale: Apply may trigger hooks and deploy unrelated pending changes.

Files: ["SKILL.md"]

## Q-frontier-sweep-dispatch

Candidate: library/local-tracked/frontier-sweep/df026dc35123 (contract-valid)

Question: Should one dispatcher own all claims and tracker updates?

Recommendation: Yes; workers return evidence rather than mutating shared ticket state.

Rationale: Shared self-assignment is not an atomic lock and hides child races.

Files: ["SKILL.md"]

## Q-frontier-sweep-herdr

Candidate: library/local-tracked/frontier-sweep/df026dc35123 (contract-valid)

Question: Does a sweep request alone authorize new Herdr topology?

Recommendation: Confirm topology separately unless already specified; allow sequential execution.

Rationale: Visibility and write isolation differ, and new workspaces consume shared resources.

Files: ["SKILL.md"]

## Q-grilling-round-size

Candidate: library/local-tracked/grilling/7bf7d17482da (contract-valid)

Question: Preserve whole-frontier rounds or cap large rounds?

Recommendation: Use the whole frontier for small sets; visibly split large independent sets.

Rationale: Maintains decision coverage without overwhelming the interviewee.

Files: ["SKILL.md"]

## Q-linear-agent-tracking-dispatch

Candidate: library/local-tracked/linear-agent-tracking/7b9526d1ffaa (contract-valid)

Question: Make one dispatcher the default for shared-account claims?

Recommendation: Yes, with worker identity and exclusive file scope recorded.

Rationale: Shared self-assignment and read-after-write do not prove exclusive ownership.

Files: ["SKILL.md"]

## Q-opencode-go-usage-refresh

Candidate: library/local-tracked/opencode-go-usage/bd31aa2be978 (contract-valid)

Question: Should a usage question implicitly refresh the monitor?

Recommendation: No; observation by default, explicit refresh authority for writers.

Rationale: Scraper invokes an override and refresh; successful write does not prove display success.

Files: ["SKILL.md"]

## Q-project-doc-planner-write

Candidate: library/local-tracked/project-doc-planner/e047c3792d6a (contract-valid)

Question: Should explicit invocation alone permit AGENTS.md and ROADMAP.md writes?

Recommendation: Require a request to create or update those files.

Rationale: Writable filesystem and skill invocation do not imply authority to change agent policy.

Files: ["SKILL.md"]

## Q-project-doc-planner-delegation

Candidate: library/local-tracked/project-doc-planner/e047c3792d6a (contract-valid)

Question: Require two agents for every assessment?

Recommendation: Retain two analytical roles, delegate only when scale and capacity justify it.

Rationale: Small inputs can be assessed directly without losing critic/planner separation.

Files: ["SKILL.md"]

Contract errors for library/pack-agent-reach/agent-reach/6cfca4cc59cc: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/agents-sdk/acf6c1c443fe: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/cloudflare-email-service/ce36c6dbab94: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/cloudflare-one-migrations/f0c4e37f07ae: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/cloudflare-one/a9e807dae019: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/cloudflare/cb252c0fc395: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/durable-objects/2328efcdf0aa: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/sandbox-migrate-to-next/85b7cc953efe: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/sandbox-next/7609f0278e83: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/sandbox-stable/31b4975c04cb: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/turnstile-spin/a976c79e435d: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/web-perf/e89d5a54146f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/workers-best-practices/703a2d204941: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-cloudflare/wrangler/78bb5b3617ef: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-diffusionstudio/editor/c2d83737eb49: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-diffusionstudio/watch/f0fb31d198a8: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-emil/animate-expo/aae80eae46b1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-emil/animate/55825656a6a9: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-emil/animation-vocabulary/17d4b1e0c079: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-emil/apple-design/430abe2199e0: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-emil/ask-sonner/c6cbfb16dce4: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-emil/emil-design-eng/29d2636669f7: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-emil/find-animation-opportunities/2612a4d24ae5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-emil/improve-animations/ca027dafd0a5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-emil/pick-ui-library/7aca0a1ae8ab: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-emil/prototype/f9a7205b9c9c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-emil/review-animations/c935d319f9be: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-emil/write-swift/7d22fc595118: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-flyai/flyai/007b65266155: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/ask-matt/b534cc6bdc1e: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/claude-handoff/dc4995f8fc90: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/code-review/e42bd4f9b13a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/codebase-design/d502a333bacc: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/diagnosing-bugs/1d2bbb504a70: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/domain-modeling/174e1cb66e7b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/git-guardrails-claude-code/11c0b4b9e16b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/grill-me/ec23057a38f1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/grill-with-docs/7db5a87b6395: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/handoff/54f21f973380: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/implement-spec/823f9625df34: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/implement/36459cdc6d63: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/improve-codebase-architecture/c51a6b463f5d: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/loop-me/7873cc59fb25: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/migrate-to-shoehorn/748a16d7f1e0: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/research/e4eb6737ad00: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/resolving-merge-conflicts/0205133738d5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/scaffold-exercises/02b942e059e2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/setup-matt-pocock-skills/94478070ab3e: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/setup-pre-commit/df9424e9fdd4: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/setup-ts-deep-modules/2617ea2ed2fd: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/tdd/e87547569ad6: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/teach/bd63a55f16b9: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/to-questionnaire/517aa2ba0c0d: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/to-spec/f4f153962db3: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/to-tickets/6034879f5e81: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/triage/eb489a70cad7: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/wait-what/f57ba739319e: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/wayfinder/51c49a387dc5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/wizard/e310e003c804: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/writing-beats/a36cf1eea07f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/writing-for-agents/9c47ca5bfd98: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/writing-fragments/cbc1834d92a7: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-mattpocock/writing-shape/488c6ee32c2c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-prime-skills/ai-image-generation/55854dd9dad1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-remotion/remotion-best-practices/612a139c71fa: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-remotion/remotion-captions/3a9baf6daf4e: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-remotion/remotion-create/459da5fdbb0f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-remotion/remotion-docs/f196f70b3bdd: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-remotion/remotion-interactivity/6bc25bec2a33: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-remotion/remotion-maps/3c60437584ef: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-remotion/remotion-markup/5b279936dc5f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-remotion/remotion-multimedia/be40e89d590f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-remotion/remotion-render/ba8b1b49c6ed: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-remotion/remotion-saas/e3fc868657d7: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-remotion/remotion-studio/ee2b84c045bb: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-remotion/remotion-upgrade/52b1c995cd1c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-supabase/supabase-postgres-best-practices/659bb86017b9: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-supabase/supabase/f1b5cf8547aa: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-unlazy/unlazy/30150f61c6d3: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/pack-vercel-labs/find-skills/75b561cc6ce7: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-chrome-devtools-mcp-claude-plugins-official/a11y-debugging/5d655059e2db: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-chrome-devtools-mcp-claude-plugins-official/chrome-devtools-cli/6dc0f82686d5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-chrome-devtools-mcp-claude-plugins-official/chrome-devtools/33113b19253c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-chrome-devtools-mcp-claude-plugins-official/debug-optimize-lcp/fb736dc3fae3: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-chrome-devtools-mcp-claude-plugins-official/memory-leak-debugging/07d0683d29d3: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-chrome-devtools-mcp-claude-plugins-official/troubleshooting/5008dd44dde1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-claude-md-management-claude-plugins-official/claude-md-improver/e5f059309df9: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-frontend-design-claude-plugins-official/frontend-design/a5b341e61bf8: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-impeccable-impeccable/impeccable/4907edb9f8db: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/brainstorming/bfa6108bd2b0: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/dispatching-parallel-agents/36f390bd9f5a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/executing-plans/7805a6c940d6: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/finishing-a-development-branch/90a3c805cec6: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/receiving-code-review/3b2f800f072f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/requesting-code-review/5a4e7aec4213: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/subagent-driven-development/528884379d88: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/systematic-debugging/a0f0f427b882: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/test-driven-development/a0968aced86f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/using-git-worktrees/47c39a222da0: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/using-superpowers/4b69905f3944: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/verification-before-completion/3eb0410021b8: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/writing-plans/c4336a137333: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-superpowers-claude-plugins-official/writing-skills/f6d0a833f5d9: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/access-protected-vercel-deployment/1e332783efc7: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/ai-gateway/d4c0ec85d33b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/ai-sdk/35b719758d19: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/auth/9b19a2160019: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/bootstrap/baaf0d52d0d5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/build-agents/2b9a4d4f196c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/cdn-caching/72dfde3f381d: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/chat-sdk/027a7299fe8b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/deployments-cicd/b1fe39fad4e9: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/env-vars/e43eec71845f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/eve/9c91a0e5ba80: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/knowledge-update/e722dc4c9e65: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/marketplace/c82d76325e1b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/microfrontends/d43b85cf3550: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/next-cache-components/a94bb50c3857: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/next-forge/806e932313ba: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/next-upgrade/e14021eb8c31: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/nextjs/5f3ae5aa6706: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/react-best-practices/ebd6c1933081: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/routing-middleware/7755e92a7757: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/runtime-cache/a45e4f2a0c49: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/shadcn/c078ddc5ad83: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/turbopack/22239b6eafd1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/vercel-agent/302d5dd8619b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/vercel-cli/97f9bf2a6a10: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/vercel-connect/1d8e3fc05aef: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/vercel-firewall/01908bdb76d8: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/vercel-functions/0a974c9bd8f2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/vercel-sandbox/a3ee2fb04d03: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/vercel-services/10f47285eeb6: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/vercel-storage/d87aa9b8a03f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/verification/4f0af7882c17: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-claude-vercel-claude-plugins-official/workflow/4f8727bf2a93: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-agents/agents-build/499d45985862: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-agents/agents-connect/1702594700d1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-agents/agents-debug/5346aeef1d45: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-agents/agents-deploy/0e729ff030e9: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-agents/agents-get-started/d841d172fce2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-agents/agents-harden/ea93e2b9fbb5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-agents/agents-optimize/2f107dd4055c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/amazon-bedrock/0b8c1b97e7ad: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-amplify/b789909a1a35: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-billing-and-cost-management/9f6357340950: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-cdk/ec68e50aefa2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-cloudformation/b2cd76551c3a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-containers/2cf90bf0b511: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-iam/a7dc1393ba48: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-messaging-and-streaming/68e691e74f66: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-observability/cefe49d2cffd: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-sdk-js-v3-usage/6c64682aee91: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-sdk-python-usage/e042315f0383: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-sdk-swift-usage/40a38a62fe03: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-secrets-manager/8b8023e0f484: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/aws-serverless/3658ec7ca026: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-aws-core/signing-in-to-aws/195d2bc09fc1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-browserstack/run-mobile-tests-on-browserstack/c6ef070d6e97: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-browserstack/run-web-tests-on-browserstack/7d88f0c3167e: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-browserstack/scan-and-fix-accessibility/5ac25e41ed8d: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cloudflare/agents-sdk/53e63d987b99: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cloudflare/building-ai-agent-on-cloudflare/df294faac715: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cloudflare/building-mcp-server-on-cloudflare/a39b20e3f999: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cloudflare/cloudflare/8c6094f0be19: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cloudflare/durable-objects/f5722b5dc383: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cloudflare/sandbox-sdk/18c76dae7ba8: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cloudflare/web-perf/c098dbce2eb3: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cloudflare/wrangler/6591efccbeec: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/analyzing-range-distribution/68ce7d33ad29: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/analyzing-schema-change-storage-risk/e25c44e6270b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/auditing-cloud-cluster-security/a3e5cd18cd5f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/auditing-table-statistics/f0c1d60ee0ce: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/benchmarking-transaction-patterns/d108942c993f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/cockroachdb-sql/42db941b9b51: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/configuring-audit-logging/c0475406e555: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/configuring-ip-allowlists/3906abd2bb8b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/configuring-log-export/11cb2be0e959: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/configuring-private-connectivity/c0c0025c4252: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/configuring-sso-and-scim/2562185bd601: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/designing-application-transactions/1df13ccc6703: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/designing-multi-region-applications/2735f6162f46: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/enabling-cmek-encryption/982715b65713: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/enforcing-password-policies/4762cc4cb878: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/hardening-user-privileges/491cb8461920: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/managing-certificates-and-encryption/62abcb85d5e7: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/managing-cluster-capacity/a4cf06617a26: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/managing-cluster-settings/27dee1202079: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/managing-tls-certificates/a394ecad4f9e: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/molt-fetch/7b53b8ee0841: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/molt-replicator/1d90772345ab: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/molt-verify/7f12807aee57: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/monitoring-background-jobs/3c780a5287e8: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/performing-cluster-maintenance/a3c34515768c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/preparing-compliance-documentation/8a201edc182c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/profiling-statement-fingerprints/cd3d5c78a633: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/profiling-transaction-fingerprints/5402a92d8ca0: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/provisioning-cluster-for-production/d0c297f6fafc: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/reviewing-cluster-health/de4de1e6eb0f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/triaging-live-sql-activity/fa2b5a28a8d5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-cockroachdb/upgrading-cluster-version/c5b9014ceb8f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datadog/ddconfig/80fe8c2d2813: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datadog/ddsetup/5bae1ace5e50: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datadog/ddtoolsets/e3121da44fc4: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-agent-assist/69903a669730: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-app-framework-cicd/fb4fcad0437e: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-data-preparation/74d54a5d672e: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-discover/17d9c3d3789d: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-external-agent-monitoring/0c66f65c38dc: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-feature-engineering/280cd13fc74c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-model-deployment/18853fab89ea: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-model-explainability/683437f0fb2b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-model-monitoring/66a4e04e5814: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-model-training/7bab4f474dbc: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-predictions/954a21fdc704: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-setup/9c3bf4488282: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-datarobot-agent-skills/datarobot-workload-api/1dc50c7a10ea: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-dbt/adding-dbt-unit-test/9a80259338b8: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-dbt/answering-natural-language-questions-with-dbt/4d3048916c32: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-dbt/building-dbt-semantic-layer/e47e866d66db: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-dbt/configuring-dbt-mcp-server/309e45a13268: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-dbt/fetching-dbt-docs/27dbb1b1e4f2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-dbt/running-dbt-commands/791103b6ce09: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-dbt/troubleshooting-dbt-job-errors/3257534c9213: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-dbt/using-dbt-for-analytics-engineering/009c9a7c5823: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-dbt/working-with-dbt-mesh/da61d7354701: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-exa/exa-best-practices/1b756f79a450: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-exa/exa-fetch/1c967d1f99c5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-exa/exa-web-search/8a70b00150d6: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-figma/figma-code-connect/81cdbb47f508: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-figma/figma-create-new-file/5c90d46b284c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-figma/figma-design-to-code/78c1636e7536: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-figma/figma-generate-design/c30fc31ed511: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-figma/figma-generate-diagram/843b9824ad86: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-figma/figma-generate-library/81e70343fc81: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-figma/figma-implement-motion/b29c6b74e6f2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-figma/figma-swiftui/21134d1b45c1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-figma/figma-use-figjam/d85568bc68ef: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-figma/figma-use-motion/51ed17d5bdb8: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-figma/figma-use-slides/38d079dfa74b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-figma/figma-use/8e40944a2609: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-firecrawl/firecrawl-agent/0423248db144: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-firecrawl/firecrawl-cli/e651e436d416: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-firecrawl/firecrawl-crawl/3ff1f85beaeb: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-firecrawl/firecrawl-download/27d674cd0e06: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-firecrawl/firecrawl-interact/8a429a2e7c76: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-firecrawl/firecrawl-map/1050abc2fcc2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-firecrawl/firecrawl-monitor/bc17ab9fd9bf: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-firecrawl/firecrawl-parse/bc8ce4f9a29d: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-firecrawl/firecrawl-scrape/b9cf54cb05c8: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-firecrawl/firecrawl-search/03d01dcdb106: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-grafana-assistant/grafana-assistant-cli/926d52c7e602: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-grafana-cloud-mcp/grafana-cloud-mcp-tools/8d3f16a1afcb: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-mintlify-cursor-plugin/mintlify/d9de53980612: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-neon-postgres/claimable-postgres/360a712a89e4: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-neon-postgres/neon-ai-gateway/eb4737fd1756: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-neon-postgres/neon-functions/34f98cad313f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-neon-postgres/neon-object-storage/88d82351bbdc: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-neon-postgres/neon-postgres-branches/545d58e1da51: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-neon-postgres/neon-postgres-egress-optimizer/113771bd03df: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-neon-postgres/neon-postgres/d1ae8a3bf23d: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-neon-postgres/neon/3509669c7edf: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-parallel/parallel-data-enrichment/31fb47581226: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-parallel/parallel-deep-research/30557e71f420: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-parallel/parallel-web-extract/b78e570fc0e9: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-parallel/parallel-web-search/968a438a355a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/analyzing-experiment-session-replays/c56de8cdbf7f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/assessing-heatmaps/8b7bbdc5b021: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/auditing-endpoints/b3b07c47a0f2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/auditing-experiments-flags/47e1c225d88b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/auditing-warehouse-data-health/5902a278e763: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/authoring-log-alerts/8b299fffbb40: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/authoring-signals-scouts/63e62fd89c09: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/cleaning-up-stale-feature-flags/ac85e13b62d1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/configuring-experiment-analytics/3c9d8eac172a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/configuring-experiment-rollout/51537307e0e6: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/consuming-endpoints-from-client-code/f945b014f659: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/copying-flags-across-projects/4ae9ddfb48c5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/creating-an-endpoint/7ab65b81397d: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/creating-experiments/5eaedb83b006: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/creating-replay-vision-scanners/49afb70d65ec: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/debugging-local-replay/d8e58f2d6dca: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/debugging-signals-pipeline/9622f1073df5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/diagnosing-endpoint-performance/2ac42588e84f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/diagnosing-experiment-results/a3e30bb24d9f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/diagnosing-failed-warehouse-syncs/bae933e3d17a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/diagnosing-missing-recordings/757a0c5149d2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/diagnosing-sdk-health/5e42d3efdeda: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/diagnosing-stacktrace-symbolication/a8d380f3d2e2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/downloading-batch-export-files/7a8cbb1eb58e: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/exploring-apm-traces/32a80b05a414: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/exploring-autocapture-events/b7023c201dd9: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/exploring-live-traffic/43c9102520c0: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/exploring-llm-clusters/6af292c6e82b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/exploring-llm-costs/c427d10fe823: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/exploring-llm-evaluations/9ef36e0a3c83: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/exploring-llm-traces/bacb49a2d388: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/exploring-signals-scouts/f8ad9bf0739b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/feature-usage-feed/8464fae918b0: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/finding-deleted-feature-flags/dba29f1e7cec: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/finding-experiments/b3bde1599348: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/finding-replay-for-issue/31a559087a82: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/finding-sessions-to-watch/828df6d09117: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/formatting-insight-axes/7bb50cf6233f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/grouping-noisy-errors/ef3fa6024cb5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/inbox-exploration/32866fda77b1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/instrument-error-tracking/2de017f12f9c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/instrument-feature-flags/3546a8bb8ccc: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/instrument-integration/44185a6e12cd: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/instrument-llm-analytics/e1ae7cd85f71: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/instrument-logs/966678e7938c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/instrument-product-analytics/f0055627d8aa: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/investigate-metric/7249b53643a1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/investigating-error-issue/d80a3a1f0eba: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/investigating-replay/8f49df6841ed: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/managing-endpoint-versions/68809fb49ace: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/managing-experiment-lifecycle/c2c6b8fc41b6: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/managing-path-cleaning-rules/a5f6b33587fb: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/managing-subscriptions/b0d318476144: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/planning-user-interviews/11787c662918: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/querying-posthog-data/50000662d49b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/setting-up-a-data-warehouse-source/4218534dbf5b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/signals-scout-ai-observability/eae454948e3f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/signals-scout-anomaly-detection/938087c7b72c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/signals-scout-csp-violations/c8cdbdfa512c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/signals-scout-error-tracking/f92aa302327b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/signals-scout-general/979d3003d517: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/signals-scout-logs/e8f41a69a020: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/signals-scout-observability-gaps/934b4f2e4393: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/signals-scout-revenue-analytics/d32253872a18: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/signals-scout-surveys/1b8635a0ddd2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/signals/6b123ab7399d: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/skills-store/a66a2e65946d: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/suggesting-data-imports/01b71b973f6b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/suppressing-noisy-errors/ec8ee0861258: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/triaging-error-issues/583582df84d2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/triaging-visual-review-runs/20c5a989754b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/tuning-incremental-sync-config/4fc17f283f85: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-posthog/working-with-skills/0169d214ed99: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-db-execute/6d3eb0e48bfd: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-db-pull/44abf49529f4: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-db-push/0dafe81e6298: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-db-seed/bf8e8098bcc1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-debug/8d3028b7bd10: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-dev/242a3e166e5c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-format/6c2847f45e0c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-generate/fb2c96009ffa: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-init/941705b000ef: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-migrate-deploy/4888dd66b64a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-migrate-dev/c2139d62c650: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-migrate-diff/f783e16f4a2b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-migrate-reset/33cbb15ce7fe: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-migrate-resolve/17e2c86b2fad: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-migrate-status/12ead01a9e6a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-studio/7cf1247970dc: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-cli-validate/1d05a0ae468b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-client-api-client-methods/130574e43a36: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-client-api-constructor/0f9991f131ad: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-client-api-filters/768f8283591a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-client-api-model-queries/6f1c83059c0c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-client-api-query-options/38e30091bb97: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-client-api-raw-queries/56c28735f794: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-client-api-relations/6e08a6d554af: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-client-api-transactions/cfaba683a555: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-database-setup-cockroachdb/3a5ff7afc254: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-database-setup-mongodb/c2fd8531ddde: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-database-setup-mysql/e2bd9a29a25e: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-database-setup-postgresql/c175c72d93e8: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-database-setup-prisma-client-setup/6b86b909d63f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-database-setup-prisma-postgres/e4e224bc4541: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-database-setup-sqlite/e002f58beb91: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-database-setup-sqlserver/3c8140aa6f45: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-upgrade-v7-accelerate-users/96c3b8da8b06: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-upgrade-v7-driver-adapters/3da2939b9600: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-upgrade-v7-env-variables/3c72c110a814: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-upgrade-v7-esm-support/91f5f66c1aa8: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-upgrade-v7-prisma-config/aaf3eb626e11: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-upgrade-v7-removed-features/6001549c268c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-prisma/prisma-upgrade-v7-schema-changes/fb66079c0b7f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-railway/use-railway/6623307ac8bc: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-snowflake-cursor-plugin/snowflake-mcp-setup/30d248478d71: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-sourcegraph-cursor-plugin/searching-sourcegraph/eba9b786eb68: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-supabase/supabase-postgres-best-practices/be67e7ab7551: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-supabase/supabase/1b86b79e384a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superdesign/superdesign/3551c5ace832: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/brainstorming/f796381eba66: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/dispatching-parallel-agents/9b9060fee286: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/executing-plans/0b8916cc6bfd: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/finishing-a-development-branch/3b2266661bc6: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/receiving-code-review/d39c45fa367a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/requesting-code-review/84db39f91b0e: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/subagent-driven-development/91e8b697ed55: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/systematic-debugging/851766e6f997: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/test-driven-development/ad20b8913b59: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/using-git-worktrees/212a999d838c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/using-superpowers/c974030af99c: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/verification-before-completion/b8a8101cc1a1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/writing-plans/3220c9c1bda2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-superpowers/writing-skills/0bf8e6e5c535: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-treg/treg/d74b00333ec7: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/accessibility-audit/d8defc491300: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/asset-audit/b422008ba807: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/bulk-cms-update/8867b0854821: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/cms-best-practices/0477a761ab16: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/cms-collection-setup/136e82cdfb42: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/code-component-command/96c2101f5cf4: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/component-audit/67aa629fe584: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/component-scaffold/b6944d447cd1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/convert-component/c9372a981890: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/custom-code-management/e8b57b82a4cf: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/deploy-guide/8b40bfb1a367: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/designer-extension-command/dd0403815e6b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/devlink-command/e72bda603fb6: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/flowkit-naming/5e42de7c279f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/link-checker/284dbc20ca28: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/local-dev-setup/54e21436dae7: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/pre-deploy-check/6b07d8ea4cff: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/safe-publish/f486e06b3931: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/site-audit/61294babd8d5: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/troubleshoot-deploy/cacb3ec655e7: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/webflow-cli-troubleshooter/67a94a7e3401: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/plugin-cursor-webflow/webflow-cloud-command/c6b90466683a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/autopilot/d108cbfd7d99: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/canvas/e39511890f90: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/create-hook/dbe91a6117c9: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/create-rule/cb48efe15340: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/create-skill/c5fd479814a2: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/create-subagent/7d45512f0d2f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/goal/fbdbe5fe88a1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/loop/bcfce6036c6d: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/migrate-to-skills/f38128ff0a51: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/new-repo/9b73385e5ff8: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/origin/3f880f24d960: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/rename-chat/8cce9a1d9114: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/review-bugbot/90c65a9c9300: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/review-security/889d605e7162: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/review/e62d132e1a28: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/sdk/2a118d5327bd: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/share/9ab9b52909d1: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/shell/0ad7d7a9bc66: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/split-to-prs/27278f7bbf13: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/statusline/9693a2836bda: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/update-cli-config/520a3aaef8fa: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-cursor/update-cursor-settings/717c4de32677: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-omarchy/diagnose-crash/4d9d34ab29ca: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-omarchy/omarchy/efc56f50e738: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-terminal-browser/terminal-browser/0690fffc934b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/provider-terminal-browser/terminal-browser/a35d93e39de3: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/canvas/b05454d485fb: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/create-hook/12219830b80a: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/create-rule/441cd7fed7e0: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/create-skill/9e6819a41d2e: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/create-subagent/6bb4d7d34e9b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/goal/bc3408f799d9: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/impeccable/2053dc80fb14: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/migrate-to-skills/de36a0532a62: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/mixture-of-agents/e8178eb74b21: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/new-repo/638c2d38919f: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/origin/7a74fab29a70: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/sdk/faad3497237b: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/share/037440f14fd3: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/update-cli-config/10e09f8ec881: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

Contract errors for library/shared/update-cursor-settings/fc492a34f929: ["REVIEW.md must be a regular file", "review.json must be a regular file"]

