#!/usr/bin/env bash
# 70-cloud.sh -- cloud provider CLIs installed outside mise.

# Fly.io CLI.
if [ -d "$HOME/.fly" ]; then
  export FLYCTL_INSTALL="$HOME/.fly"
  _path_prepend "$FLYCTL_INSTALL/bin"
  export PATH
fi

# Google Cloud SDK. The vendored completion script is bash-specific, so it is
# only sourced under bash; the PATH entry applies to any shell.
if [ -f "$HOME/dev/harlan-web/google-cloud-sdk/path.bash.inc" ]; then
  . "$HOME/dev/harlan-web/google-cloud-sdk/path.bash.inc"
fi
if [ "$SHELL_KIND" = bash ] && [ -f "$HOME/dev/harlan-web/google-cloud-sdk/completion.bash.inc" ]; then
  . "$HOME/dev/harlan-web/google-cloud-sdk/completion.bash.inc"
fi
