# Agent Reach — source-grounded candidate review

Status: reviewed for human inspection; not approved or deployed.

Disposition: retain the router with the authority corrections below as an
optional internet-research-acquisition pack. Do not place it in universal core
until the human decisions in `review.json` are settled and provider support is
maintained. Its value is the platform-specific routing and failure knowledge,
not a promise that every backend is installed or available.

## Pack and invocation

Proposed pack: `internet-research-acquisition` (optional, not universal core).
Invoke when the user asks to research/search/look up internet content, shares a
URL, or names one of the listed platforms. Use only the requested platform and
the access scope the user accepts; a dedicated platform skill takes precedence.
The pack fetches source material only. Writing reports, analysis or
translations, and posting/commenting/liking, remain separate tasks.

Recommended execution is task-triggered and read-only: run the health check only
for an explicitly requested login-backed platform, select the reported backend,
read the matching reference, follow its retry chain, and require non-empty
content before treating a lookup as successful. Keep temporary output under
`/tmp/` or a user-approved destination. If a backend is unavailable, report the
limitation instead of installing, logging in, importing cookies, or changing
system configuration without explicit authorization.

Alternatives are a public web-reader/search route for public web content, a
dedicated platform skill, or a user-directed provider already configured on the
machine. These alternatives do not establish that Agent Reach itself was used.

## Full-tree read and provenance

The one frozen full-tree variant was read file by file: all 9 baseline regular
files, including both entrypoints and all 7 references. There are no separate
scripts, examples, metadata files, binary assets, symlinks or license files in
this tree; command and Python examples embedded in the references were included
in the read. The frozen tree has 35,343 bytes and tree SHA-256
`6cfca4cc59ccdee025e4e204c35e0d09622fedbb4dd65feaae3103a4493fd2e8`, with
entrypoint SHA-256
`621796ede32bbac680dcbc9f15110cdb9b569ebffc3de27ed9aafda9e0f9fbcf`.

The inventory declares `Panniantong/Agent-Reach` as the repository and
`/home/harlan/.agents/skills/agent-reach` as the shared source mirror, with
certainty `declared source, installed revision unknown` and no version. Before
the review rewrite, all 9 candidate files matched their recorded source-mirror
hashes. No license was found within bounded source ancestry, so redistribution
permission is unknown; this review does not grant it.

Reviewed paths:

- `SKILL.md`
- `SKILL_en.md`
- `references/career.md`
- `references/dev.md`
- `references/finance.md`
- `references/search.md`
- `references/social.md`
- `references/video.md`
- `references/web.md`

## Retained expertise and changes

The entrypoints retain bilingual trigger boundaries, the seven-category route
table, doctor/backend selection, explicit Twitter environment handling, the
XiaoHongShu browser-cookie boundary, OpenCLI adapter discovery, output-location
guidance, and pointers to every reference. The references retain the useful
platform distinctions: LinkedIn MCP, GitHub CLI, Exa/Jina/RSS, X/Twitter retry
ordering, Bilibili's `yt-dlp` prohibition, Xueqiu's HTTP-400 interpretation,
Reddit's login requirement, Instagram's user-search limitation, YouTube
caption retries, and provider fallback/cost disclosure for transcription.

The candidate rewrite is intentionally small:

- Both entrypoints now make platform access conditional on the user's accepted
  scope, make broad multi-platform collection need-driven, and make update
  checks opt-in. They state that configuration, login, installation and browser
  session operations require explicit authorization, with credential storage,
  location and possible cost explained first. The two inline question markers
  are `Q-agent-reach-core` and `Q-agent-reach-authority`.
- `references/dev.md` labels the GitHub section read-only by default and calls
  out auth, clone, sync, create, fork and release commands as separately
  authorized operations.
- `references/career.md`, `references/finance.md`, `references/social.md` and
  `references/video.md` now make login, cookie import, dependency installation,
  key configuration, browser-session use and system installation explicit
  authority boundaries.
- `REVIEW.md` and `review.json` are the new review artifacts; no baseline file
  was removed, renamed, converted to another type, or replaced with an asset.

## Provider, dependency and maintenance limits

The tree routes across Exa via `mcporter`, Jina Reader, GitHub CLI, `yt-dlp`,
`bili-cli`, OpenCLI, `twitter-cli`, `rdt-cli`, xiaohongshu-mcp, LinkedIn MCP,
PRAW, `feedparser`, `ffmpeg`, and Groq/OpenAI transcription providers. It also
assumes a user-controlled Chrome session for several OpenCLI paths. These are
external dependencies, not bundled assets. The doctor output is described as a
capability signal, not proof that a target request works; provider availability,
authentication, result quality, rate limits and current platform policy were
not live-tested here.

The source declares upstream ownership as `Panniantong/Agent-Reach`, but the
installed revision and release are unknown. The references themselves identify
`rdt-cli` and `bili-cli` as having stopped upstream maintenance, describe
`twitter-cli` as requiring 0.8.5+, and use unpinned `uvx ...@latest` for LinkedIn.
Those details should be reverified before promotion. The pack engine, provider
metadata, and dedicated-skill precedence are also outside this tree.

Possible future maintenance decisions are to keep both language entrypoints
with one canonical loader, retire stale fallback providers when they no longer
work, and keep the pack optional until its provider matrix has an owner. Do not
merge all provider commands into a universal core skill merely because the
upstream collection advertises 15 platforms.

## Static walkthroughs versus executed checks

Static walkthroughs covered: a public URL lookup; a named login-backed platform
whose doctor result is null; a missing backend; a Twitter request requiring
explicit child-process credentials; a GitHub search versus a GitHub create
operation; a YouTube caption retry; an unavailable caption provider requiring
transcription; a cross-provider fallback with possible cost; and a request to
install or configure a dependency. The expected outcome in each case is
task-scoped read-only work or an explicit user-authorized handoff.

Executed validation was limited to the repository's review contract and safe
fixture suites listed in `PR_DESCRIPTION.md`. No candidate command, provider,
browser session, network lookup, login, install, transcription, or update check
was run. Contract validation proves file preservation and review metadata shape;
it does not prove semantic behavior or provider availability.

## Human promotion boundary

This is review readiness, not human approval, installation or deployment. The
human must decide whether the optional pack belongs in core (`Q-agent-reach-core`)
and whether every configuration/login/install/browser-session action requires
per-action consent (`Q-agent-reach-authority`). Provider maintenance, license
permission, credentials, costs, live availability and final invocation metadata
remain outside what this frozen tree can establish.
