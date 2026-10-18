# Get editor completions based on the config schema
"$schema" = 'https://starship.rs/config-schema.json'

add_newline = true
command_timeout = 5000
# Rendered from ~/.config/omarchy/themed/starship.toml.tpl on `omarchy theme set`;
# STARSHIP_CONFIG points here (~/.config/shell/10-tools.sh). Every prompt color
# resolves through the named palette below, which follows the Omarchy theme.
palette = "dots"

format = "${custom.k8s}${custom.docker}${custom.gcp}$line_break$username$hostname[$directory$git_branch$git_status$git_state]($style)$git_commit$character"

# Exit status (nonzero only) and a dim clock live on the right side so the
# left line stays short. Rendered into RPROMPT/RPS1 by the shell integrations.
right_format = "$status$time"

# Named palette block (must stay BELOW the top-level format/right_format keys
# — a table header claims every later bare key for itself).
[palettes.dots]
cyan = "{{ accent }}"
red = "{{ red }}"
blue = "{{ blue }}"
white = "{{ foreground }}"

[character]
error_symbol = "[❯](bold red)"
success_symbol = "[❯](bold cyan)"

[status]
disabled = false
format = "[✗ $status]($style) "
style = "bold red"

[time]
disabled = false
format = "[ $time]($style)"
style = "dimmed white"
time_format = "%H:%M"

[directory]
truncation_symbol = "…/"
style = "bold cyan"
repo_root_style = "bold cyan"
repo_root_format = "[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) "
# Anchor for the 2-visible-component truncation: ~/dev/foo reads as ~d/foo.
# (An extra component is kept so the ~d anchor survives truncation.)
truncation_length = 3
substitutions = { "~/dev" = "~d" }

[git_branch]
format = "[$symbol$branch]($style) "
style = "italic cyan"

[git_status]
style = "cyan"
ignore_submodules = true
ahead = "↑${count} "
diverged = "⇅↑${ahead_count}↓${behind_count} "
behind = "↓${count} "
conflicted = "≠ "
up_to_date = ""
untracked = "? "
modified = "± "
stashed = "≡ "
staged = "◆ "
renamed = "» "
deleted = "✕ "

# Active kubectl context. Parsed from ~/.kube/config on disk (no kubectl call).
[custom.k8s]
command = '''sed -n 's/^current-context:[[:space:]]*//p' "$HOME/.kube/config" 2>/dev/null | head -n 1 | sed 's/^gke_[^_]*_[^_]*_//' | tr -d "'\"" '''
when = '''test -f "$HOME/.kube/config"'''
format = "[ ☸ $output]($style) "
style = "bold #326ce5"
shell = ["sh"]
ignore_timeout = true

# Active docker context; hidden unless one is explicitly set (default is noise).
[custom.docker]
command = '''sed -n 's/.*"currentContext":[[:space:]]*"\([^"]*\)".*/\1/p' "$HOME/.docker/config.json" 2>/dev/null | head -n 1'''
when = '''grep -q '"currentContext"' "$HOME/.docker/config.json" 2>/dev/null'''
format = "[ 🐳 $output]($style) "
style = "bold #2496ed"
shell = ["sh"]
ignore_timeout = true

# Active gcloud configuration + project. Parsed from disk (no gcloud call)
# so the prompt stays fast; hidden entirely when gcloud is not configured.
[custom.gcp]
command = '''
c=$(cat "$HOME/.config/gcloud/active_config" 2>/dev/null) || exit 1
f="$HOME/.config/gcloud/properties"
[ "$c" != "default" ] && [ -f "$HOME/.config/gcloud/configurations/config_$c" ] && f="$HOME/.config/gcloud/configurations/config_$c"
p=$(sed -n 's/^[[:space:]]*project[[:space:]]*=[[:space:]]*//p' "$f" 2>/dev/null | head -n 1)
[ -n "$p" ] && p=" $p"
printf '%s%s\n' "$c" "$p"
'''
when = "test -f \"$HOME/.config/gcloud/active_config\""
format = "[ ☁ $output]($style) "
style = "bold blue"
shell = ["sh"]
ignore_timeout = true

[git_commit]
only_detached = true
commit_hash_length = 7
format = "[($hash)]($style) "
style = "italic dimmed cyan"

[git_state]
format = "[($state( $progress_current/$progress_total))]($style) "
style = "bold cyan"

[username]
format = "[$user]($style)@"
style_user = "bold cyan"
style_root = "bold cyan"

[hostname]
ssh_only = true
# Hostname, shown only over SSH.
format = "[$hostname]($style) "
style = "bold dimmed cyan"
