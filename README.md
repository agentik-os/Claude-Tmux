# Tmux Agentik OS

> A modern tmux configuration for developers running multiple projects on a VPS.
> Designed for Claude Code / AI-assisted development workflows.

![Status Bar Preview](examples/statusbar-preview.png)

## Features

- **Option/Alt key shortcuts** - No more `Ctrl+b` prefix needed!
- **Interactive project menus** - `c-projectname` opens a menu to manage sessions
- **Global session selector** - `ts` to view/manage all sessions
- **Status bar with metrics** - RAM, CPU, Disk, Git branch, tunnel status
- **Ralph integration** - AI development workflow shortcuts
- **Mouse support** - Scroll, click, resize panes
- **Clean minimal theme** - No background colors, just subtle text

## Quick Install

```bash
# Clone the repo
git clone https://github.com/agentik-os/tmux-agentik-os.git ~/.tmux-agentik-os

# Run installer
~/.tmux-agentik-os/install.sh
```

## Keyboard Shortcuts

### Session Navigation (Option/Alt key)

| Shortcut | Action |
|----------|--------|
| `⌥ Z` | List all sessions & windows (interactive tree) |
| `⌥ X` | Previous session |
| `⌥ V` | Next session |
| `⌥ B` | Last used session |

### Window Navigation

| Shortcut | Action |
|----------|--------|
| `⌥ W` | List windows (current session) |
| `⌥ A` | Previous window |
| `⌥ S` | Next window |
| `⌥ Q` | Last used window |

### Management

| Shortcut | Action |
|----------|--------|
| `⌥ K` | Kill session (with confirmation) |
| `⌥ D` | Close window (with confirmation) |
| `⌥ N` | New window |
| `⌥ R` | Rename session |
| `⌥ T` | Rename window |

### Panes & Other

| Shortcut | Action |
|----------|--------|
| `⌥ F` | Fullscreen/Zoom pane (toggle) |
| `⌥ H` | Split horizontal |
| `⌥ J` | Split vertical |
| `⌥ C` | Copy mode (scroll + select) |

### Ralph Integration (Ctrl+b prefix)

| Shortcut | Action |
|----------|--------|
| `Ctrl+b r` | Launch Ralph in new window |
| `Ctrl+b R` | Switch to Ralph window |
| `Ctrl+b K` | Kill Ralph window |

## Terminal Commands

### Session Management

```bash
# Global selector - manage all sessions
ts

# Quick list of sessions
tps

# Project-specific menu (creates aliases for your projects)
c-myproject
```

### Project Menu Features

When you run `c-projectname`:
- View existing sessions
- Create new session
- Delete sessions
- Clean project cache (safe - keeps Claude data)
- Init/refresh Claude context
- NUCLEAR option (kill all + clean caches)

## Status Bar

The status bar shows:

```
[ 14:30 · SessionName · main · BG 2 ]────[ Ralph · Tunnel ✓ · TS 3 · RAM 45% · CPU 12% · Disk 67% · Push 2h ]
```

- **Time** - Current time
- **Session** - Active session name
- **Git branch** - Current branch
- **BG** - Background tasks count
- **Ralph** - Ralph status (if running)
- **Tunnel** - SSH tunnel status
- **TS** - Total sessions count
- **RAM/CPU/Disk** - System metrics
- **Push** - Time since last git push

## Configuration

### Adding Project Aliases

Edit your `~/.zshrc` or `~/.bashrc`:

```bash
# Add your projects
alias c-myproject='tmux-project MyProject /path/to/project'
alias c-another='tmux-project Another /path/to/another'
```

### Customizing the Theme

Edit `~/.tmux.conf` and modify the colors:

```bash
# Status bar colors (using hex)
set -g status-style bg=default,fg='#888888'

# Active window
setw -g window-status-current-style bg=default,fg='#FFFFFF',bold

# Accent color (orange by default)
# Change #c96442 to your preferred color
```

## File Structure

```
tmux-agentik-os/
├── tmux.conf              # Main tmux configuration
├── install.sh             # Installation script
├── scripts/
│   ├── tmux-project       # Project menu script
│   ├── tmux-select        # Global selector script
│   ├── ram-usage.sh       # RAM metric
│   ├── cpu-usage.sh       # CPU metric
│   ├── disk-usage.sh      # Disk metric
│   ├── git-branch.sh      # Git branch display
│   ├── sessions-count.sh  # Session counter
│   ├── tunnel-status.sh   # Tunnel status
│   ├── bg-tasks.sh        # Background tasks
│   ├── last-push.sh       # Last push time
│   └── ralph-*.sh         # Ralph integration
├── themes/
│   └── minimal.conf       # Minimal theme (default)
└── examples/
    └── zshrc-aliases.sh   # Example aliases
```

## Requirements

- tmux 3.0+
- zsh or bash
- [TPM](https://github.com/tmux-plugins/tpm) (optional, for plugins)

## Credits

Created by [Agentik OS](https://github.com/agentik-os) for AI-assisted development workflows.

## License

MIT
