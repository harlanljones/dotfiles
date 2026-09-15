#!/usr/bin/env bash
# setup.sh — Interactive onboarding and setup wizard for new machines.
#
# DEPRECATED as the bootstrap entry point: use ./install.sh (or the one-liner in
# README.md) on a bare machine — it installs chezmoi if needed and runs
# `chezmoi init --apply`, whose run_* hooks own the heavy setup. This wizard
# remains as an optional interactive supplement (machine/theme choice, age key
# retrieval from 1Password, per-package prompts) for machines where the
# defaults need hand-holding. Its interactive toolchain installs were folded
# conceptually into install.sh + run_* hooks; nothing here is required for
# bootstrap.
# Inspects system hardware, OS, and environment, clarifies configuration
# with the user, and orchestrates toolchains, dotfiles, and secrets.

set -euo pipefail

for _p in "$HOME/.local/share/mise/shims" "$HOME/.local/bin" "$HOME/.cache/.bun/bin"; do
  case ":${PATH}:" in
    *":$_p:"*) ;;
    *) PATH="$_p:$PATH" ;;
  esac
done
export PATH

# ──────────────────────────────────────────────────────────────────────────
# Styling & UI Helpers
# ──────────────────────────────────────────────────────────────────────────

if [[ -t 1 ]] && command -v tput >/dev/null 2>&1 && [[ "$(tput colors 2>/dev/null || echo 0)" -ge 8 ]]; then
  BOLD=$(tput bold); DIM=$(tput dim); RESET=$(tput sgr0)
  BLUE=$(tput setaf 4); GREEN=$(tput setaf 2); YELLOW=$(tput setaf 3); RED=$(tput setaf 1); CYAN=$(tput setaf 6)
else
  BOLD=""; DIM=""; RESET=""; BLUE=""; GREEN=""; YELLOW=""; RED=""; CYAN=""
fi

NON_INTERACTIVE=false
DRY_RUN=false

for arg in "$@"; do
  case "$arg" in
    -y|--yes|--non-interactive) NON_INTERACTIVE=true ;;
    -n|--dry-run) DRY_RUN=true ;;
    -h|--help)
      cat <<EOF
${BOLD}Dotfiles Setup & Onboarding Wizard${RESET}

${BOLD}USAGE:${RESET}
  ./setup.sh [options]

${BOLD}OPTIONS:${RESET}
  -y, --yes, --non-interactive  Accept detected defaults without interactive prompts
  -n, --dry-run                 Preview detection and configuration without installing
  -h, --help                    Show this help message
EOF
      exit 0
      ;;
  esac
done

banner() {
  printf '\n%s%s======================================================%s\n' "$BOLD" "$CYAN" "$RESET"
  printf '%s%s   Dotfiles Setup & Onboarding Wizard%s\n' "$BOLD" "$CYAN" "$RESET"
  printf '%s%s======================================================%s\n' "$BOLD" "$CYAN" "$RESET"
  printf '%s  Inspects system info, clarifies machine profile and settings,%s\n' "$DIM" "$RESET"
  printf '%s  and provisions runtimes, AI agents, and chezmoi dotfiles.%s\n\n' "$DIM" "$RESET"
}

step()    { printf '\n%s%s[%s/7] %s%s\n' "$BOLD" "$BLUE" "$1" "$2" "$RESET"; }
info()    { printf '  %sℹ%s %s\n' "$CYAN" "$RESET" "$1"; }
success() { printf '  %s✓%s %s\n' "$GREEN" "$RESET" "$1"; }
warn()    { printf '  %s⚠%s %s\n' "$YELLOW" "$RESET" "$1"; }
err()     { printf '  %s✖%s %s\n' "$RED" "$RESET" "$1" >&2; }

confirm() {
  local prompt="$1" default="${2:-Y}" reply=""
  if [[ "$NON_INTERACTIVE" == "true" ]]; then
    [[ "$default" =~ ^[Yy] ]] && return 0 || return 1
  fi
  if [[ "$default" =~ ^[Yy] ]]; then
    printf '  %s? %s [Y/n]: %s' "$YELLOW" "$prompt" "$RESET"
  else
    printf '  %s? %s [y/N]: %s' "$YELLOW" "$prompt" "$RESET"
  fi
  read -r reply || true
  reply="${reply:-$default}"
  [[ "$reply" =~ ^[Yy] ]]
}

ask_choice() {
  local prompt="$1" default_val="$2" chosen=""
  shift 2
  local options=("$@")
  if [[ "$NON_INTERACTIVE" == "true" ]]; then
    echo "$default_val"
    return 0
  fi
  printf '  %s? %s%s\n' "$YELLOW" "$prompt" "$RESET"
  for i in "${!options[@]}"; do
    local num=$((i + 1))
    local marker=" "
    [[ "${options[$i]}" == "$default_val" ]] && marker="*"
    printf '    %s%s %s) %s%s\n' "$DIM" "$marker" "$num" "${options[$i]}" "$RESET"
  done
  printf '  Select [1-%s] (default: %s): ' "${#options[@]}" "$default_val"
  read -r chosen || true
  if [[ -z "$chosen" ]]; then
    echo "$default_val"
  elif [[ "$chosen" =~ ^[0-9]+$ ]] && (( chosen >= 1 && chosen <= ${#options[@]} )); then
    echo "${options[$((chosen - 1))]}"
  else
    echo "$chosen"
  fi
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

banner

# ──────────────────────────────────────────────────────────────────────────
# 1. System Inspection & Machine Clarification
# ──────────────────────────────────────────────────────────────────────────
step "1" "Inspecting System Environment"

SYS_OS="$(uname -s)"
SYS_ARCH="$(uname -m)"
SYS_KERNEL="$(uname -r)"
SYS_HOST="$(hostname -s 2>/dev/null || hostname)"
IS_WSL=false
DISTRO_ID="unknown"
DISTRO_NAME="Unknown"

if [[ "$SYS_OS" == "Linux" ]]; then
  if grep -qi "microsoft" /proc/version 2>/dev/null || [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
    IS_WSL=true
  fi
  if [[ -f /etc/os-release ]]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    DISTRO_ID="${ID:-unknown}"
    DISTRO_NAME="${PRETTY_NAME:-$NAME}"
  fi
elif [[ "$SYS_OS" == "Darwin" ]]; then
  DISTRO_ID="macos"
  DISTRO_NAME="macOS $(sw_vers -productVersion 2>/dev/null || true)"
fi

printf '  %-16s %s%s%s\n' "Operating System:" "$BOLD" "$SYS_OS" "$RESET"
printf '  %-16s %s\n' "Distribution:" "$DISTRO_NAME"
printf '  %-16s %s\n' "Architecture:" "$SYS_ARCH"
printf '  %-16s %s\n' "Kernel:" "$SYS_KERNEL"
printf '  %-16s %s\n' "Hostname:" "$SYS_HOST"
if [[ "$IS_WSL" == "true" ]]; then
  printf '  %-16s %sYes (Windows Subsystem for Linux)%s\n' "WSL Environment:" "$GREEN" "$RESET"
fi

# Detect recommended machine role
RECOMMENDED_MACHINE="unknown"
if [[ "$SYS_HOST" == "omarchy" ]] || [[ "$DISTRO_ID" == "arch" && "$IS_WSL" == "false" ]]; then
  RECOMMENDED_MACHINE="augustus"
elif [[ "$SYS_HOST" == "MacBookPro" ]] || [[ "$SYS_OS" == "Darwin" ]]; then
  RECOMMENDED_MACHINE="hadrian"
elif [[ "$SYS_HOST" == "DESKTOP-UTOJEVB" ]] || [[ "$IS_WSL" == "true" ]]; then
  RECOMMENDED_MACHINE="vespasian"
elif [[ "$SYS_OS" == "Linux" ]]; then
  RECOMMENDED_MACHINE="augustus"
fi

info "Detected environment best matches profile: ${BOLD}${RECOMMENDED_MACHINE}${RESET}"

CHOICE_OUTPUT="$(ask_choice "Clarify machine role for this device:" "$RECOMMENDED_MACHINE" \
  "augustus  (Arch Linux / Omarchy desktop: Hyprland, systemd daemons, pacman)" \
  "hadrian   (macOS workstation: Homebrew, native terminal, macOS defaults)" \
  "vespasian (Ubuntu 24.04 on WSL2: Windows Terminal, apt manifest, mise CLIs)" \
  "custom    (Specify a custom machine identifier)")"

case "$CHOICE_OUTPUT" in
  augustus*) SELECTED_MACHINE="augustus" ;;
  hadrian*)  SELECTED_MACHINE="hadrian" ;;
  vespasian*) SELECTED_MACHINE="vespasian" ;;
  custom*)
    printf '  Enter custom machine name: '
    read -r SELECTED_MACHINE || SELECTED_MACHINE="custom"
    ;;
  *) SELECTED_MACHINE="${CHOICE_OUTPUT%% *}" ;;
esac

success "Machine profile set to: ${BOLD}$SELECTED_MACHINE${RESET}"

# ──────────────────────────────────────────────────────────────────────────
# 2. Color Theme Selection
# ──────────────────────────────────────────────────────────────────────────
step "2" "Color Theme Selection"

DEFAULT_THEME="tokyonight-storm"
if [[ -f .chezmoidata/machines.yaml ]]; then
  EXISTING_THEME=$(awk -v machine="$SELECTED_MACHINE" '
    $1 == machine ":" { in_m = 1; next }
    in_m && /^[a-zA-Z]/ { in_m = 0 }
    in_m && /^[[:space:]]*name:/ {
      sub(/^[[:space:]]*name:[[:space:]]*/, "");
      sub(/[[:space:]].*$/, "");
      print;
      exit
    }
  ' .chezmoidata/machines.yaml 2>/dev/null || true)
  [[ -n "$EXISTING_THEME" ]] && DEFAULT_THEME="$EXISTING_THEME"
fi

THEME_CHOICE="$(ask_choice "Select system color theme:" "$DEFAULT_THEME" \
  "tokyonight-night (Classic Tokyo Night dark)" \
  "tokyonight-storm (Deep dark blue variant)" \
  "tokyonight-moon  (Soft indigo dark variant)" \
  "tokyonight-day   (Light mode variant)")"

SELECTED_THEME="${THEME_CHOICE%% *}"
success "Selected theme: ${BOLD}$SELECTED_THEME${RESET}"

# ──────────────────────────────────────────────────────────────────────────
# 3. System Package Management
# ──────────────────────────────────────────────────────────────────────────
step "3" "System Packages & Dependencies"

MISSING_PKGS=()
check_cmd() { command -v "$1" >/dev/null 2>&1; }

if ! check_cmd git; then MISSING_PKGS+=("git"); fi
if ! check_cmd age; then MISSING_PKGS+=("age"); fi

if [[ "$SYS_OS" == "Darwin" ]]; then
  if ! check_cmd brew; then
    warn "Homebrew is not installed."
    if confirm "Install Homebrew now?" "Y"; then
      [[ "$DRY_RUN" == "false" ]] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  fi
  if [[ -f dot_Brewfile ]]; then
    if confirm "Run 'brew bundle' to install packages from dot_Brewfile?" "Y"; then
      if [[ "$DRY_RUN" == "false" ]]; then
        brew bundle --file=dot_Brewfile || warn "Some brew packages failed to install."
      fi
    fi
  fi
elif [[ "$DISTRO_ID" == "ubuntu" || "$DISTRO_ID" == "debian" ]]; then
  APT_PKG_FILE="$SCRIPT_DIR/dot_config/apt/pkglist.txt"
  if [[ -f "$APT_PKG_FILE" ]]; then
    while IFS= read -r pkg || [[ -n "$pkg" ]]; do
      [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
      if ! dpkg -s "$pkg" >/dev/null 2>&1; then
        MISSING_PKGS+=("$pkg")
      fi
    done < "$APT_PKG_FILE"
  fi

  if [[ ${#MISSING_PKGS[@]} -gt 0 ]]; then
    info "Missing apt package(s): ${MISSING_PKGS[*]}"
    if confirm "Install missing packages with apt-get?" "Y"; then
      if [[ "$DRY_RUN" == "false" ]]; then
        sudo apt-get update
        sudo apt-get install -y "${MISSING_PKGS[@]}"
      fi
      success "Apt packages installed successfully."
    fi
  else
    success "All required system packages are installed."
  fi
elif [[ "$DISTRO_ID" == "arch" ]]; then
  PACMAN_PKG_FILE="$SCRIPT_DIR/dot_config/pacman/pkglist.txt"
  if [[ -f "$PACMAN_PKG_FILE" ]]; then
    if confirm "Synchronize pacman packages from pkglist.txt?" "Y"; then
      if [[ "$DRY_RUN" == "false" ]]; then
        # shellcheck disable=SC2024
        sudo pacman -S --needed - < "$PACMAN_PKG_FILE" || warn "Pacman sync incomplete."
      fi
    fi
  fi
fi

get_op_cmd() {
  if command -v op.exe >/dev/null 2>&1; then
    echo "op.exe"
  elif command -v op >/dev/null 2>&1; then
    echo "op"
  else
    echo ""
  fi
}

# ──────────────────────────────────────────────────────────────────────────
# 4. Age Encryption Secret Key
# ──────────────────────────────────────────────────────────────────────────
step "4" "Age Encryption Secrets Setup"

KEY_FILE="$HOME/.config/chezmoi/key.txt"
mkdir -p "$(dirname "$KEY_FILE")"
OP_BIN="$(get_op_cmd)"

if [[ -f "$KEY_FILE" ]]; then
  success "Age private key found at $KEY_FILE"
  if [[ -n "$OP_BIN" ]]; then
    if confirm "Back up this age private key to 1Password?" "N"; then
      printf '  Enter 1Password vault name (leave blank for default vault): '
      read -r OP_VAULT || OP_VAULT=""
      vault_args=()
      if [[ -n "$OP_VAULT" ]]; then
        vault_args=("--vault=$OP_VAULT")
      fi
      if [[ "$DRY_RUN" == "false" ]]; then
        if "$OP_BIN" item get "chezmoi-age-key" ${vault_args[@]+"${vault_args[@]}"} >/dev/null 2>&1; then
          if "$OP_BIN" item edit "chezmoi-age-key" notesPlain="$(cat "$KEY_FILE")" ${vault_args[@]+"${vault_args[@]}"} 2>/dev/null; then
            success "Age key successfully updated in 1Password."
          else
            warn "Could not update 1Password item. Ensure 1Password is unlocked."
          fi
        else
          if "$OP_BIN" item create --category="Secure Note" --title="chezmoi-age-key" notesPlain="$(cat "$KEY_FILE")" ${vault_args[@]+"${vault_args[@]}"} 2>/dev/null; then
            success "Age key successfully backed up to 1Password."
          else
            warn "Could not create 1Password item. Ensure 1Password is unlocked."
          fi
        fi
      fi
    fi
  fi
else
  warn "No age private key found at $KEY_FILE"
  info "Encrypted files (e.g. opencode.json.age) cannot be decrypted without this key."
  info "Target age recipient (public): age1hf4200nhdqg0l3xs68v4gef6mn0nuvmh72573m3nfj8kqpcs7pnsmfkuw6"

  KEY_SOURCE="$(ask_choice "How would you like to provide the age key?" "1password" \
    "1password (Retrieve existing key from 1Password vault using 'op read')" \
    "manual    (Paste an existing age secret key string)" \
    "generate  (Generate a new age keypair for this machine)" \
    "skip      (Skip for now; private files will remain hidden)")"

  case "$KEY_SOURCE" in
    1password*)
      if [[ -z "$OP_BIN" ]]; then
        warn "1Password CLI not found. Installing via mise..."
        if [[ "$DRY_RUN" == "false" ]]; then
          mise install 1password-cli 2>/dev/null || true
          eval "$("$HOME/.local/bin/mise" activate bash 2>/dev/null || true)"
          OP_BIN="$(get_op_cmd)"
        fi
      fi
      printf '  Enter 1Password item name or URI [chezmoi-age-key]: '
      read -r OP_URI || OP_URI=""
      OP_URI="${OP_URI:-chezmoi-age-key}"
      if [[ "$DRY_RUN" == "false" && -n "$OP_BIN" ]]; then
        if [[ "$OP_URI" == op://* ]]; then
          "$OP_BIN" read "$OP_URI" > "$KEY_FILE" 2>/dev/null || true
        else
          "$OP_BIN" item get "$OP_URI" --fields notesPlain > "$KEY_FILE" 2>/dev/null || true
        fi
        if [[ -s "$KEY_FILE" ]]; then
          chmod 600 "$KEY_FILE"
          success "Age key retrieved from 1Password and saved to $KEY_FILE (0600)"
        else
          err "Failed to read key from 1Password. Ensure 1Password is unlocked."
          rm -f "$KEY_FILE"
        fi
      fi
      ;;
    manual*)
      printf '  Enter age secret key (starts with AGE-SECRET-KEY-1...): '
      stty -echo 2>/dev/null || true
      read -r USER_AGE_KEY || USER_AGE_KEY=""
      stty echo 2>/dev/null || true
      printf '\n'
      if [[ "$USER_AGE_KEY" =~ ^AGE-SECRET-KEY-1 ]]; then
        if [[ "$DRY_RUN" == "false" ]]; then
          printf '%s\n' "$USER_AGE_KEY" > "$KEY_FILE"
          chmod 600 "$KEY_FILE"
        fi
        success "Age key saved to $KEY_FILE (permissions: 0600)"
      else
        err "Invalid key format (must start with AGE-SECRET-KEY-1). Skipping key save."
      fi
      ;;
    generate*)
      if check_cmd age-keygen; then
        if [[ "$DRY_RUN" == "false" ]]; then
          age-keygen -o "$KEY_FILE"
          chmod 600 "$KEY_FILE"
          NEW_PUB=$(age-keygen -y "$KEY_FILE")
          success "Generated new age keypair. Public key: $NEW_PUB"
        fi
      else
        err "age-keygen not installed. Install age package first."
      fi
      ;;
    *)
      info "Skipping age key configuration. You can add it anytime to $KEY_FILE."
      ;;
  esac
fi

# ──────────────────────────────────────────────────────────────────────────
# 5. Mise Toolchain & Runtimes
# ──────────────────────────────────────────────────────────────────────────
step "5" "Mise Toolchain & Development Runtimes"

if ! check_cmd mise; then
  info "Mise runtime manager not found."
  if confirm "Install mise now?" "Y"; then
    if [[ "$DRY_RUN" == "false" ]]; then
      curl -fsSL https://mise.run | sh
      export PATH="$HOME/.local/bin:$PATH"
    fi
    success "Mise installed."
  fi
fi

if check_cmd mise; then
  info "Mise manages: Python, Go, Node.js, pnpm, Ruby, Terraform, Neovim, etc."
  if confirm "Install/update all tools declared in mise configuration?" "Y"; then
    if [[ "$DRY_RUN" == "false" ]]; then
      eval "$("$HOME/.local/bin/mise" activate bash 2>/dev/null || true)"
      mise install
    fi
    success "Mise tools provisioned."
  fi
fi

# ──────────────────────────────────────────────────────────────────────────
# 6. AI Agent CLIs & Ecosystem
# ──────────────────────────────────────────────────────────────────────────
step "6" "AI Agent CLIs & Extensions"

# Bun check
if ! check_cmd bun; then
  if confirm "Install Bun (fast JavaScript/TypeScript runtime & package manager)?" "Y"; then
    if [[ "$DRY_RUN" == "false" ]]; then
      curl -fsSL https://bun.sh/install | bash
      export PATH="$HOME/.bun/bin:$PATH"
    fi
    success "Bun installed."
  fi
fi

# OpenCode
if ! check_cmd opencode; then
  if confirm "Install OpenCode AI CLI?" "Y"; then
    if [[ "$DRY_RUN" == "false" ]]; then
      curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path
      export PATH="$HOME/.opencode/bin:$PATH"
    fi
    success "OpenCode installed."
  fi
fi

# Bun global CLIs (Cline, Grok, Wrangler, Supabase, etc.)
if check_cmd bun; then
  if confirm "Install global agent CLIs via Bun (cline, grok, wrangler, supabase, etc.)?" "Y"; then
    if [[ "$DRY_RUN" == "false" ]]; then
      bun install -g cline @xai-official/grok wrangler supabase freebuff @nanonets/graft @magnitudedev/cli
    fi
    success "Global agent CLIs installed."
  fi
fi

# ──────────────────────────────────────────────────────────────────────────
# 7. Chezmoi Configuration & Synchronization
# ──────────────────────────────────────────────────────────────────────────
step "7" "Synchronizing Dotfiles with Chezmoi"

CHEZMOI_CONFIG="$HOME/.config/chezmoi/chezmoi.toml"
mkdir -p "$(dirname "$CHEZMOI_CONFIG")"

if [[ "$DRY_RUN" == "false" ]]; then
  # Write or update local machine definition
  cat <<EOF > "$CHEZMOI_CONFIG"
encryption = "age"

[age]
identity = "~/.config/chezmoi/key.txt"
recipient = "age1hf4200nhdqg0l3xs68v4gef6mn0nuvmh72573m3nfj8kqpcs7pnsmfkuw6"

[onepassword]
prompt = true
EOF
  if [[ "$IS_WSL" == "true" ]]; then
    echo 'command = "op.exe"' >> "$CHEZMOI_CONFIG"
  fi
  cat <<EOF >> "$CHEZMOI_CONFIG"

[data]
machine = '$SELECTED_MACHINE'
EOF
  success "Chezmoi configuration written ($CHEZMOI_CONFIG)."

  # Apply chezmoi dotfiles
  if check_cmd chezmoi; then
    info "Applying dotfiles to \$HOME..."
    chezmoi apply --source "$SCRIPT_DIR"
    success "Dotfiles applied."
  else
    warn "chezmoi executable not found. Make sure mise shims are loaded in your shell."
  fi

  # Apply theme selection if dots CLI is available
  if check_cmd dots; then
    info "Applying theme: $SELECTED_THEME..."
    dots theme set "$SELECTED_THEME" || true
  fi
fi

# ──────────────────────────────────────────────────────────────────────────
# Summary & Next Steps
# ──────────────────────────────────────────────────────────────────────────
printf '\n%s%s======================================================%s\n' "$BOLD" "$GREEN" "$RESET"
printf '%s%s   Setup Complete!%s\n' "$BOLD" "$GREEN" "$RESET"
printf '%s%s======================================================%s\n' "$BOLD" "$GREEN" "$RESET"
printf '  Profile: %s%s%s | Theme: %s%s%s\n\n' "$BOLD" "$SELECTED_MACHINE" "$RESET" "$BOLD" "$SELECTED_THEME" "$RESET"
printf '  %sNext steps:%s\n' "$BOLD" "$RESET"
printf '  1. Restart your terminal or run: %sexec bash%s\n' "$CYAN" "$RESET"
printf '  2. Run health diagnostics:       %sdots doctor%s\n' "$CYAN" "$RESET"
if [[ ! -f "$KEY_FILE" ]]; then
  printf '  3. %sAdd your age key%s to %s to decrypt private configs\n' "$YELLOW" "$RESET" "$KEY_FILE"
fi
printf '\n'
