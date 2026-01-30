#!/bin/bash
# Kill Ralph window
# Called by tmux keybinding Ctrl+b K

SESSION=$(tmux display-message -p '#S')

if tmux list-windows -t "$SESSION" 2>/dev/null | grep -q "Ralph"; then
    # Kill the Ralph window
    tmux kill-window -t "$SESSION:Ralph"
    tmux display-message "🛑 Ralph window killed"
else
    tmux display-message "No Ralph window to kill"
fi
