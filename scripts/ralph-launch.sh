#!/bin/bash
# Launch Ralph in a new window within the current tmux session
# Called by tmux keybinding Ctrl+b r

SESSION=$(tmux display-message -p '#S')
WINDOW_NAME="Ralph"

# Check if Ralph window already exists in this session
if tmux list-windows -t "$SESSION" 2>/dev/null | grep -q "$WINDOW_NAME"; then
    tmux display-message "Ralph window already exists! Use Ctrl+b R to switch."
    exit 0
fi

# Get current working directory
CWD=$(tmux display-message -p '#{pane_current_path}')

# Check if .ralph directory exists (Ralph is configured)
if [[ ! -d "$CWD/.ralph" ]]; then
    tmux display-message "No .ralph/ folder found. Run 'ralph-enable' first."
    exit 1
fi

# Create new window with Ralph
tmux new-window -t "$SESSION" -n "$WINDOW_NAME" -c "$CWD" "ralph; read -p 'Ralph exited. Press Enter to close...'"

tmux display-message "🤖 Ralph started in window '$WINDOW_NAME'"
