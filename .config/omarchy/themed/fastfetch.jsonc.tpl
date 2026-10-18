// Rendered from ~/.config/omarchy/themed/fastfetch.jsonc.tpl on `omarchy theme set`.
// A theme can ship its own fastfetch.jsonc, which is used instead.
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "type": "file",
    "source": "~/.config/omarchy/branding/about.txt",
    "color": { "1": "{{ accent }}", "2": "{{ foreground }}" },
    "padding": { "top": 1, "right": 4, "left": 1 }
  },
  "display": { "disableLinewrap": true },
  "modules": [
    { "type": "custom", "outputColor": "{{ muted }}", "format": "┌──────────────────────Hardware──────────────────────┐" },
    { "type": "host", "key": " PC", "keyColor": "{{ green }}" },
    { "type": "cpu", "key": "│ ├", "showPeCoreCount": true, "keyColor": "{{ green }}" },
    { "type": "gpu", "key": "│ ├", "detectionMethod": "pci", "hideType": "integrated", "format": "{name}", "keyColor": "{{ green }}" },
    { "type": "display", "key": "│ ├󱄄", "compactType": "original-with-refresh-rate", "keyColor": "{{ green }}" },
    { "type": "disk", "key": "│ ├󰋊", "keyColor": "{{ green }}" },
    { "type": "memory", "key": "└ └", "keyColor": "{{ green }}" },
    { "type": "custom", "outputColor": "{{ muted }}", "format": "└────────────────────────────────────────────────────┘" },
    { "type": "custom", "outputColor": "{{ muted }}", "format": "┌──────────────────────Software──────────────────────┐" },
    { "type": "command", "key": " OS", "keyColor": "{{ blue }}", "text": "echo \"Omarchy $(omarchy-version 2>/dev/null)\"" },
    { "type": "kernel", "key": "│ ├", "keyColor": "{{ blue }}" },
    { "type": "wm", "key": "│ ├", "keyColor": "{{ blue }}" },
    { "type": "uptime", "key": "│ ├󱫐", "keyColor": "{{ blue }}" },
    { "type": "packages", "key": "│ ├󰏖", "keyColor": "{{ blue }}" },
    { "type": "command", "key": "│ ├󰈸", "keyColor": "{{ blue }}", "text": "n=$(timeout 1 yadm status --porcelain --untracked-files=no 2>/dev/null | wc -l); echo \"Dotfiles: $n changed\"" },
    { "type": "command", "key": "└ └󰸌", "keyColor": "{{ blue }}", "text": "printf '%s \\033[38m●\\033[37m●\\033[36m●\\033[35m●\\033[34m●\\033[33m●\\033[32m●\\033[31m●\\033[0m\\n' \"$(omarchy-theme-current 2>/dev/null)\"" },
    { "type": "custom", "outputColor": "{{ muted }}", "format": "└────────────────────────────────────────────────────┘" },
    "break",
    "colors"
  ]
}
