---
name: market-competitor-research
description: Use when researching products, competitors, or markets.
---

# Market & Competitor Research

Class of task: user asks to research a product space, find competitors, compare projects, or sanity-check vendor claims. Deliverable is a decision document, not just an answer.

## Procedure

1. **Round-based parallel search.** Run 3 web_search queries per round (independent, batched in one turn). Round 1: broad landscape ("<category> product launch <year>"), the user's named terms, and the top competitor names the user mentioned. Round 2: drill into the specific differentiators/decision axes from round 1. Round 3: fill coverage gaps per axis.
1b. **Seed from curated awesome-lists.** Search `github.com` for an `awesome-<category>` list early — one list can map 60+ projects with one-line feature summaries, which rounds 2–3 then drill into. Cross-check list entries against `gh repo view <owner>/<repo> --json stargazerCount,licenseInfo,pushedAt,latestRelease` before citing any of them as an incumbent: lists rot and their one-liners can overstate.
2. **Identify the architectural fork that splits the field.** In fast-moving tool markets there is usually one structural decision (e.g. how a tool gets its provider tokens / which protocol layer it speaks) that determines each project's economics and risk. Build the compatibility analysis around that fork, not around feature checklists.
3. **Check first-party moves before recommending any wedge.** A vendor (platform owner) shipping natively within months kills standalone products at the 'convenience' layer. Search for the vendor's own announcements; note which user-facing wedges they have just absorbed.
4. **Sanity-check load-bearing claims by cloning repos.** For every project the recommendation depends on: `git clone --depth 1 <url>` into /tmp, then grep the source for the README's headline claims (feature keyword in the implementation language, test files, module names). Verify the README's stated gaps too — an honest 'not here yet' is itself a market signal. Report a docs-vs-implementation table; flag any repo where claims exceed code as unreliable evidence.
5. **Read repo READMEs without browsing:** `gh api repos/<owner>/<repo>/readme --jq .content | base64 -d`.
6. **Deliver:** findings summary → decision matrix → recommendation → open risks. Save the full doc under `~/Documents/<topic>-research/decision-matrix.md` (create the dir), state the path, and keep the chat reply a condensed version, not a paste of the doc.
7. **If the research leads to a new product:** follow on with (a) candidate names grouped by branding direction, scored in the same weighted decision-matrix format (state the criteria and weights, name the winner and the challenger, and say what would break the tie); run the RDAP check on every name before recommending it, and re-rank if the winner's domain set fails; (b) a project scaffold (`~/dev/<name>/` with README.md, SPEC-product.md, SPEC-technical.md, docs/ carrying the research doc) so the spec set is self-contained. Ask before creating the directory only if the location is ambiguous — `~/dev` is this user's default dev root.
7b. **Positioning doctrine for consumer-facing products (user's standing preference):** the primary interface targets maximum adoption by the general population — playful, zero math/jargon uninvited; depth (research, benchmarks, fairness proofs, technical pages) lives behind one quiet click. Define the transparency split explicitly: engine/verifiable parts open source, user dataset and derived analysis private — code openness kills rigging/trust accusations while private data preserves the content edge. Pedantic framing may live in the marketing *threads* (for expert audiences) but never in the product UI.

## Decision matrix format (default deliverable)

Score each candidate wedge/product 1–5 on: Pain, Fit (for the delivery surface in question), Coverage (how well existing products incl. first-party solve it), First-party risk, Defensibility. Verdict per row: BUILD / WATCH / DROP, one clause why. Follow with a positioning section that names what to build, what to sit on top of, and what not to compete with.

## Decision points go through the interactive question tool
When a branch genuinely needs the user (ruin rulings, metric choices, what to work on next), batch the independent decisions into ONE clarify call — recommended option first, up to 4 choices each — instead of asking in prose or picking unilaterally. Brainstorming continues between calls; do not serialize questions.

## Pitfalls

- web_extract fails on Reddit pages ('Website Not Supported'). Get the discussion via web_search instead — HN threads surface with full comment text and carry the real signal for developer-tool sentiment.
- Fast-growing repos invalidate third-party summaries: a repo can gain thousands of stars and full test suites within months of a claim that it is a prototype. When a community claim contradicts a repo's code, trust the code you cloned.
- Tiny projects can already implement a wedge's MVP (read-only, single-platform, no commercial layer). Check them before recommending a wedge as 'ungap' — the moat is usually the combination (write-back + multi-platform + monetizable layer), not invention.
- Do not store dated market facts (launch dates, star counts, policy news) in skills or standing docs — they are stale within weeks. The decision doc in ~/Documents is the snapshot; skills carry only the method.
- A `dig +short <domain> A` returning empty only means no A record. Use RDAP for an authoritative check: `GET https://rdap.org/domain/<name>` returning 404 = registry-confirmed unregistered; 200 with events = registered with dates. Rate-limit retries (429) with a 2s sleep, not abandonment. Still present the final call as 'verify at a registrar' — RDAP 404 is strong but not a purchase.
- Registrar availability widgets are usually unusable programmatically: public search endpoints are bot-walled (403 'Just a moment...') or login-gated, and the on-page widget may serve 'search unavailable'. Don't burn turns fighting them — registry RDAP is the same source of truth they query. Check registrar TLD coverage before recommending a name: some registrars (e.g. Cloudflare) sell only ICANN gTLDs, not ccTLDs like .gg, so a 'free' ccTLD domain may be unusable at the user's registrar of choice.
- Some TLD registries (e.g. .run) block anonymous RDAP (403) and whois falls through to the IANA TLD record — mark those 'verify at registrar' rather than guessing.
- When the user supplies third-party platform data (social-API research dumps), merge it as a dated snapshot file in the research dir and cite its method, but re-derive the decision implications yourself: engagement metrics tell you format-fit (bookmarks ≈ archive-worthy reference content, likes ≈ reach) and audience shortlists, and keyword-pollution findings (e.g. product-category terms swamped by spam) should change the product's own copy choices.
