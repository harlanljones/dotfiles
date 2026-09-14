# Vespasian boot model

Vespasian is Ubuntu 24.04 under WSL2 on Windows 11. The Windows session owns GUI
processes (GlazeWM, Zebar, Flow Launcher, QuickLook, AutoHotkey, and the
terminal window); WSL owns Linux daemons and CLI tooling through systemd.

## Process Isolation and Keepalive

WSL2 terminates the distribution when no interactive sessions remain, which
would stop systemd user daemons (`herdr-outpost-relay.service`,
`wsl-ssh-bridge`) and force a cold boot on the next terminal launch.

To prevent this, `run_onchange_after_47-vespasian-wsl-boot.sh.tmpl` creates the
Windows scheduled task `Dots WSL Ubuntu-24.04 Keepalive`:

- **Execution:** Runs a hidden `wsl.exe -d <distro> --exec /usr/bin/sleep infinity`.
- **Unlimited runtime:** Configured with `ExecutionTimeLimit = 0` (`PT0S`) so
  Windows Task Scheduler never terminates it after the default 72-hour cutoff.
- **Immediate start:** Started immediately on apply (`Start-ScheduledTask`) and
  re-triggered on Windows logon (`-AtLogOn`).
- **Session bound:** Tied to the logged-in Windows user so GUI processes and
  WSLg share the interactive desktop session.

### Desktop Tools Lifecycle

Windows GUI tools (GlazeWM, Zebar, AutoHotkey, Flow Launcher, QuickLook) are
native Windows processes. They are never spawned as WSL bash background jobs (`&`),
which would tie their lifecycle to a WSL subshell and terminate them when a
terminal closes.

Instead:
1. They are registered in the Windows user Startup folder
   (`%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\`) via
   `run_onchange_after_45-vespasian-desktop-tools.sh.tmpl`.
2. Apply hooks launch them through PowerShell `Start-Process`, fully detached
   from the WSL session.
3. GlazeWM leaves Zebar running across config reloads (`shutdown_commands: []`),
   allowing Zebar to reconnect seamlessly without restarting.

## Systemd and User Services

Enable the systemd user manager once:

```bash
sudo loginctl enable-linger "$USER"
```

Verify boot and service state:

```bash
loginctl show-user "$USER" -p Linger
systemctl --user --no-pager --failed
systemctl --user status herdr-outpost-relay.service
```

Check the keepalive task status from WSL:

```bash
powershell.exe -NoProfile -Command 'Get-ScheduledTask "Dots WSL Ubuntu-24.04 Keepalive"'
```

## Keybindings (Omarchy Parity)

GlazeWM keybindings match Omarchy (Hyprland) defaults from Augustus, supporting
both `Win` and `Alt` modifiers:

| Action | Binding (Win) | Binding (Alt) | Target Command |
| :--- | :--- | :--- | :--- |
| **Terminal** | `Win + Enter` | `Alt + Enter` | WezTerm (primary) / Windows Terminal fallback |
| **Browser** | `Win + Shift + B`<br>`Win + B`<br>`Win + Shift + Enter` | `Alt + Shift + B`<br>`Alt + B`<br>`Alt + Shift + Enter` | Google Chrome |
| **Private Browser** | `Win + Shift + Alt + B` | — | Google Chrome (Incognito) |
| **File Manager** | `Win + Shift + F` | `Alt + Shift + F` | File Explorer (`explorer.exe`) |
| **Editor / IDE** | `Win + Shift + N` | `Alt + Shift + N` | VS Code (`code`) |
| **Passwords** | `Win + Shift + /` | `Alt + Shift + /` | 1Password (`1password:`) |
| **Calculator** | `Win + Ctrl + Q` | `Alt + Ctrl + Q` | Windows Calculator (`calc.exe`) |
| **App Launcher** | `Win + Space` | `Alt + Space` | Flow Launcher |
| **Close Window** | `Win + W` / `Win + Q` | `Alt + W` / `Alt + Shift + Q` | GlazeWM `close` |
| **Toggle Floating** | `Win + T` / `Win + Shift + Space` | `Alt + T` / `Alt + Shift + Space` | GlazeWM `toggle-floating --centered` |
| **Toggle Tiling Split** | `Win + V` | `Alt + V` | GlazeWM `toggle-tiling-direction` |
| **Fullscreen** | `Win + F` | `Alt + F` | GlazeWM `toggle-fullscreen` |
| **Minimize** | `Win + M` | `Alt + M` | GlazeWM `toggle-minimized` |
| **Vim Focus** | `Win + H / J / K / L` | `Alt + H / J / K / L` | Focus left / down / up / right |
| **Vim Move** | `Win + Shift + H / J / K / L` | `Alt + Shift + H / J / K / L` | Move left / down / up / right |
| **Workspaces** | `Win + 1..9` | `Alt + 1..9` | Switch to workspace 1–9 |
| **Move to Workspace** | `Win + Shift + 1..9` | `Alt + Shift + 1..9` | Move window to workspace 1–9 |
| **Resize Mode** | `Win + R` | `Alt + R` | Resize mode (Enter/Esc to exit) |
| **Reload Config** | `Win + Shift + R` | `Alt + Shift + R` | GlazeWM `wm-reload-config` |
| **Exit WM** | `Win + Shift + E` | `Alt + Shift + E` | GlazeWM `wm-exit` |
| **Gaming Mode** | `Win + Shift + P` | `Alt + Shift + P` | GlazeWM `wm-toggle-pause` |
| **ChatGPT** | `Win + Shift + A` | `Alt + Shift + A` | `https://chatgpt.com` |
| **Grok** | `Win + Shift + Alt + A` | — | `https://grok.com` |
| **X** | `Win + Shift + X` | `Alt + Shift + X` | `https://x.com` |
| **YouTube** | `Win + Shift + Y` | `Alt + Shift + Y` | `https://youtube.com` |

WezTerm is the native primary terminal shortcut (`Win+Enter`), running natively
on Windows with DirectWrite hardware acceleration, the synchronized dots theme,
and default WSL domain. Windows Terminal remains available via `Alt+Enter` as a
native fallback.
