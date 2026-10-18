{
  "name": "Omarchy",
  "type": "custom",
  "text": {
    "primary": "{{ foreground }}",
    "secondary": "{{ dark_foreground }}",
    "response": "{{ foreground }}"
  },
  "background": {
    "primary": "{{ background }}",
    "diff": {
      "added": "{{ mix background green 20% }}",
      "removed": "{{ mix background red 20% }}"
    }
  },
  "border": {
    "default": "{{ selection }}",
    "focused": "{{ accent }}"
  },
  "ui": {
    "comment": "{{ muted }}",
    "symbol": "{{ dark_foreground }}",
    "gradient": ["{{ blue }}", "{{ magenta }}", "{{ cyan }}"]
  },
  "Background": "{{ background }}",
  "Foreground": "{{ foreground }}",
  "LightBlue": "{{ cyan }}",
  "AccentBlue": "{{ magenta }}",
  "AccentPurple": "{{ magenta }}",
  "AccentCyan": "{{ cyan }}",
  "AccentGreen": "{{ yellow }}",
  "AccentYellow": "{{ green }}",
  "AccentRed": "{{ red }}",
  "DiffAdded": "{{ mix background green 20% }}",
  "DiffRemoved": "{{ mix background red 20% }}",
  "Comment": "{{ muted }}",
  "Gray": "{{ dark_foreground }}",
  "DarkGray": "{{ dark_background }}",
  "GradientColors": ["{{ blue }}", "{{ magenta }}", "{{ cyan }}"]
}
