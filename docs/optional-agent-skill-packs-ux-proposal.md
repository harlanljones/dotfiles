# Optional Agent Skill Packs

## UX proposal for review

### Summary

Our current dotfiles setup makes the full agent-skill catalog globally discoverable across Codex, Claude, Cline, Cursor, Gemini, Grok, Pi, and related harnesses. This is convenient, but it creates unnecessary skill-list noise and contributes to context-budget warnings such as “skill descriptions were shortened.”

The proposed feature keeps a small set of core skills always available and lets users activate larger optional packs only when they need them.

The goal is not to remove capabilities. It is to make the default workspace quieter while keeping specialized capabilities one deliberate action away.

## User problem

An agent user may have access to more than 100 skills, even though most sessions use only a handful. The current behavior creates several problems:

- Skill descriptions consume discovery and context budget.
- It is difficult to understand which skills are intentionally active.
- Specialized skills can compete with one another for attention.
- Every harness receives nearly the same catalog, even when the harness does not support or need every skill.
- A user may hesitate to install useful packs because the default result feels cluttered.

## Primary user story

> As an agent user, I want my everyday skill catalog to stay small and relevant, while being able to activate a specialized skill pack quickly when a task requires it.

### Secondary user stories

- As a multi-harness user, I want to activate a pack for one harness or for all harnesses.
- As a user working offline, I want already-installed packs to remain available without downloading them again.
- As a user managing two machines, I want my enabled-pack choices to be reproducible through chezmoi.
- As a user troubleshooting context size, I want to see which packs are active and how many skills they contribute.

## Proposed experience

Add a small `dots skill` command surface:

```text
dots skill list
dots skill enable remotion
dots skill disable remotion
dots skill enable cloudflare --harness codex
dots skill run remotion-create
```

The exact command names are implementation details; the UX principle is explicit activation with clear visibility into state.

### Default state

The default state contains:

- Locally maintained workflow skills.
- Skills required by the dotfiles system itself.
- A small number of high-frequency shared skills.
- Provider-specific skills that are already part of a harness’s normal setup.

Large specialist collections such as Remotion, Cloudflare, animation, image generation, Swift, and Supabase are inactive by default.

### Pack activation

When a user enables a pack, the system should:

1. Install or restore the pack if it is not already cached.
2. Show the skills that will become discoverable.
3. Link those skills only into the selected harness roots.
4. Report the resulting context/discovery change.

Example confirmation:

```text
Enable pack “Remotion”?

12 skills will become available to Codex.
Estimated additional skill descriptions: 12.
Already cached locally: yes.

[Enable] [Cancel]
```

### Pack deactivation

Disabling a pack should remove only links managed by the pack system. It must preserve:

- Provider-owned files.
- User-created files.
- Skills explicitly enabled by another pack.
- The downloaded cache, unless the user separately asks to clean it.

This makes enable/disable reversible and fast.

### One-off activation

For occasional use, the user should be able to activate a single skill for one command or session:

```text
dots skill run remotion-create
```

This avoids permanently changing global discovery for a task that will not recur.

## Suggested information architecture

```text
Agent skills
├── Active now
│   ├── Core
│   ├── Custom workflow
│   └── Enabled packs
├── Optional packs
│   ├── Remotion
│   ├── Cloudflare
│   ├── Animation & UI
│   ├── Image generation
│   ├── Supabase
│   └── Other installed catalogs
└── Skill cache
```

The important distinction is between:

- **Installed**: available locally and usable without downloading.
- **Active**: visible to a harness during normal skill discovery.

These states should not be conflated.

## Per-harness behavior

The user should be able to choose a scope:

- Codex only.
- Current harness.
- All supported harnesses.

The default should be the current harness or Codex, depending on where the command is run. “All harnesses” should be an explicit choice because it increases global discovery breadth.

Provider-specific variants, such as different builds of `impeccable`, should remain owned by their provider and should not be replaced by generic shared links.

## Status and feedback

The status view should answer four questions quickly:

1. What is active?
2. What is installed but inactive?
3. Which harnesses receive each pack?
4. How much discovery overhead does each pack add?

Example:

```text
Active packs
  core                 8 skills   all harnesses
  cloudflare           inactive   cached
  remotion             inactive   cached
  impeccable           provider-managed 6 variants

Current discovery: 16 skills for Codex
Cached but inactive: 47 skills
```

The exact “overhead” metric may initially be a skill count rather than token estimation. Count is predictable and easy to explain.

## Important UX decisions

### Persisted or temporary activation

Recommended default: activation persists through chezmoi-managed state, with a one-off command for temporary use.

This supports reproducible machine setup without forcing every machine to expose every skill.

### Machine-specific preferences

Pack activation should support machine-specific state. A macOS laptop may need different active packs from the Omarchy desktop.

The shared manifest should define what is available; a small machine-local or machine-profile section should define what is active.

### Offline behavior

If a pack is cached, activation should work offline. If it is not cached, the command should fail with a clear explanation and an install option rather than silently changing the active state.

### Conflict handling

If two packs provide a skill with the same name, the status view should explain which provider wins. The system should avoid silently replacing a provider-owned skill.

## Suggested first release

The first version can stay intentionally small:

- Add `core` and `optional` pack categories to the skill manifest.
- Add an enabled-pack list with a default of `core`.
- Change synchronization to expose only active packs.
- Add `dots skill list`, `enable`, and `disable`.
- Preserve cached inactive packs.
- Support Codex-only activation first, then add per-harness scope.

The one-off `run` command and detailed overhead estimates can follow after the basic model is proven.

## Success criteria

- A new machine starts with a concise, useful skill catalog.
- Users can activate a specialized pack in one discoverable command.
- Deactivation does not delete cached content or user-owned skills.
- Activation state is understandable and reproducible.
- The default Codex session no longer needs to shorten skill descriptions because of the optional catalog.
- Existing custom and provider-owned skills continue to work unchanged.

## Open questions for UX

1. Should activation be exposed only through the CLI, or also through a small local dashboard/status view?
2. Should “all harnesses” be available in the first release, or should the first release stay Codex-only?
3. Should packs be organized by source repository, user goal, or task domain?
4. Should an inactive cached pack be surfaced in agent suggestions, or remain invisible until explicitly enabled?
5. What is the clearest wording for the distinction between “installed” and “active”?
6. Should enabling a pack require confirmation when it adds more than a threshold number of skills?

## Relevant current implementation

The current manifest is in `.chezmoidata/agent_skills.yaml`. Installation currently uses `skills add -g -a '*'` in `run_onchange_before_09-install-agent-skills.sh.tmpl`, and `run_after_23-sync-agent-skills.sh.tmpl` mirrors the complete shared catalog into the harness discovery roots. These are the primary integration points for the proposed feature.
