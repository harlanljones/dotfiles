#!/usr/bin/env bash
# 20-integrations.sh -- shell hooks for CLI tools Omarchy doesn't set up.
# zoxide, fzf, starship and mise are initialized by Omarchy's base rc.
# if/fi rather than `cmd && …` so a missing tool doesn't fail `source`.

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init bash)"
fi
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# 1Password CLI completion.
if command -v op >/dev/null 2>&1; then
  eval "$(op completion bash)"
fi

# 1Password SSH agent, for tools that read SSH_AUTH_SOCK rather than
# ~/.ssh/config's IdentityAgent (ssh-add, some git GUIs).
if [ -S "$HOME/.1password/agent.sock" ]; then
  export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
fi
