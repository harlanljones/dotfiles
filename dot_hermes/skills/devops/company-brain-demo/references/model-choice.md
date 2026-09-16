# Synthesis model decision matrix (OpenRouter-routed)

For citation_required RAG synthesis over small corpora (demo scale: hundreds of files). Scores 1-5 (5 = best). Prices are list $/M tokens (in/out), approximate — re-verify against openrouter.ai/models before relying on them.

| Model (OpenRouter id) | Grounding/citations | Answer quality | Speed | Cost efficiency | Reliability | GBrain integration |
|---|---|---|---|---|---|---|
| openrouter:anthropic/claude-haiku-4.5 | 5 | 4 | 4 | 3 | 5 | 5 |
| openrouter:google/gemini-2.5-flash | 4 | 4 | 5 | 4 | 5 | 4 |
| openrouter:openai/gpt-5.4-mini | 4 | 4 | 4 | 3 | 5 | 4 |
| openrouter:deepseek/deepseek-v4-flash | 3 | 4 | 4 | 5 | 3 | 4 |
| openrouter:google/gemini-2.5-flash-lite | 2 | 3 | 5 | 5 | 4 | 4 |
| openrouter:meta-llama/llama-4-scout | 2 | 3 | 5 | 5 | 4 | 3 |
| openrouter:mistralai/mistral-large-3 | 3 | 3 | 4 | 4 | 4 | 3 |
| openrouter:anthropic/claude-sonnet-4.6 | 5 | 5 | 3 | 1 | 5 | 5 |

How to choose:

- The decision column for citation_required demos is GROUNDING, not raw quality — the differentiator is how rarely the model invents a citation or writes a chatty refusal.
- DeepSeek V4 Flash wins on price and is first-class in GBrain (live abort/retry pin for the `deepseek/` family in openrouter-families.ts), but peak-hour throttling makes it a demo-day risk.
- Flash-lite tier saves little that matters and loses citation discipline; skip it for anything citation_required.
- Sonnet-class breaks a 'Haiku or cheaper' cost rule; keep it listed only as the reference point for what spending more buys.

Verification before swapping in production: re-run the smoke suite (denied probes depend on the model's refusal verbosity — a more talkative model can fail the leak scorer on honest denials), and confirm entrypoint.sh re-asserts the new `openrouter:<vendor>/<model>` for both models.default and models.tier.deep.
