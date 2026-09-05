#!/usr/bin/env bash
# 50-agents.sh -- wrappers around coding agents that need more than an alias.

# Global safety wrapper for the Cline CLI.
#
# The prompt text alone is NOT enforcement: cline runs with auto-approve on by
# default, so an LLM instruction like this can simply be ignored (and has
# been). The actual block is technical: prepend ~/.local/bin/cline-safety to
# PATH for this invocation only, so its `git` wrapper shadows the real git and
# hard-refuses `commit`/`push` regardless of what cline decides to do.
# `VAR=val cmd` only sets PATH for this command (and its children) -- it does
# not touch PATH in the current shell.
cline() {
    local safety_bin="$HOME/.local/bin/cline-safety"
    local safety_prompt="[CRITICAL SAFETY CONSTRAINT: Never execute or attempt to run terminal commands containing 'git commit' or 'git push'. If changes are ready, stop execution immediately and prompt the user to run them manually.]"

    # Check if you passed arguments, append the constraint to the instruction
    if [ $# -gt 0 ]; then
        PATH="$safety_bin:$PATH" bun run cline "$*. $safety_prompt"
    else
        PATH="$safety_bin:$PATH" bun run cline
    fi
}
