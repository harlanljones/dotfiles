#!/bin/sh
# install.sh — one-line bootstrap for a bare machine.
#
#   curl -fsLS https://raw.githubusercontent.com/harlanljones/dotfiles/main/install.sh -o /tmp/dotfiles-install.sh \
#       && sh /tmp/dotfiles-install.sh
#
# ... or after cloning:
#
#   ~/.local/share/chezmoi/install.sh
#
# Thin on purpose: it only guarantees git, curl and chezmoi, then hands off to
# `chezmoi init --apply`, whose run_* hooks own all heavy setup. Re-runs are
# safe (idempotent). Interactive TTY is expected on first apply: the encrypted
# opencode entry prompts for the age identity.

set -eu

REPO="https://github.com/harlanljones/dotfiles.git"

main() {
    if [ "$(id -u)" -eq 0 ]; then
        echo "error: do not run this as root — run it as your normal user" >&2
        exit 1
    fi

    # Missing deps: print the package-manager hint for this OS, install nothing.
    missing=""
    for cmd in git curl; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing="$missing $cmd"
        fi
    done
    if [ -n "$missing" ]; then
        case "$(uname -s)" in
            Darwin)
                echo "missing:$missing — install with: xcode-select --install && brew install$missing" >&2
                ;;
            Linux)
                if [ -r /etc/os-release ]; then
                    # shellcheck disable=SC1091
                    . /etc/os-release
                    case "${ID:-unknown} ${ID_LIKE:-}" in
                        *arch*|*endeavouros*|*manjaro*)
                            echo "missing:$missing — install with: sudo pacman -S --needed$missing" >&2
                            ;;
                        *fedora*|*rhel*|*centos*|*rocky*|*almalinux*|*amzn*)
                            echo "missing:$missing — install with: sudo dnf install -y$missing" >&2
                            ;;
                        *debian*|*ubuntu*|*pop*|*linuxmint*|*wsl*)
                            echo "missing:$missing — install with: sudo apt-get install -y$missing" >&2
                            ;;
                        *)
                            echo "missing:$missing — install git and curl with your package manager" >&2
                            ;;
                    esac
                else
                    echo "missing:$missing — install git and curl with your package manager" >&2
                fi
                ;;
            *)
                echo "missing:$missing — install git and curl, then re-run" >&2
                ;;
        esac
        exit 1
    fi

    # Install chezmoi itself if absent (idempotent: skipped when present).
    # The install script is captured to a file first: a `sh -c "$(curl ...)"`
    # one-liner silently exits 0 when curl fails (empty script runs and
    # succeeds), which looks like success on a broken network.
    if ! command -v chezmoi >/dev/null 2>&1; then
        echo "installing chezmoi to ~/.local/bin ..."
        mkdir -p "$HOME/.local/bin"
        script="$HOME/.local/bin/.chezmoi-install.sh"
        if ! curl -fsLS get.chezmoi.io -o "$script" || [ ! -s "$script" ]; then
            rm -f "$script"
            echo "error: failed to download the chezmoi installer — check your network and re-run" >&2
            exit 1
        fi
        if ! sh "$script" -- -b "$HOME/.local/bin"; then
            rm -f "$script"
            echo "error: chezmoi installer failed" >&2
            exit 1
        fi
        rm -f "$script"
    fi

    # Ensure the freshly installed binary is on PATH for this invocation.
    PATH="$HOME/.local/bin:$PATH"
    export PATH

    # Warn about pre-existing dotfiles that would be overwritten.
    # Detects: a well-known rc file exists AND chezmoi has no prior state
    # (no ~/.config/chezmoi) — i.e. this is a first apply over real dotfiles.
    # With a TTY: prompt before proceeding. Non-interactive: print the warning
    # loudly and proceed; set CHEZMOI_INSTALL_ASSUME_YES=0 to abort instead.
    conflicts=""
    if [ ! -d "$HOME/.config/chezmoi" ]; then
        for f in "$HOME/.zshrc" "$HOME/.bashrc" "$HOME/.gitconfig"; do
            if [ -f "$f" ]; then
                conflicts="$conflicts $f"
            fi
        done
    fi
    if [ -n "$conflicts" ]; then
        echo "WARNING: existing dotfiles detected and they are NOT yet managed by chezmoi:" >&2
        for f in $conflicts; do
            echo "  $f" >&2
        done
        echo "WARNING: 'chezmoi init --apply' will OVERWRITE these files (backups are kept as .bak only if configured)." >&2
        echo "Safer options: run 'chezmoi init' without --apply to diff first, or use the guided setup.sh." >&2
        if [ -t 0 ]; then
            printf "Proceed and overwrite? [y/N] "
            read -r answer
            case "$answer" in
                y|Y|yes|YES) ;;
                *)
                    echo "aborted — nothing was changed. Run 'chezmoi init $REPO' (no --apply) to inspect the diff first." >&2
                    exit 1
                    ;;
            esac
        elif [ "${CHEZMOI_INSTALL_ASSUME_YES:-1}" != "1" ]; then
            echo "aborted by CHEZMOI_INSTALL_ASSUME_YES=0 (non-interactive, conflicts detected) — nothing was changed." >&2
            exit 1
        else
            echo "non-interactive: proceeding and overwriting (set CHEZMOI_INSTALL_ASSUME_YES=0 to abort instead)." >&2
        fi
    fi

    echo "chezmoi: applying $REPO"
    echo "note: an interactive TTY is expected — the encrypted opencode entry prompts for your age identity on first apply."
    exec chezmoi init --apply "$REPO"
}

main
