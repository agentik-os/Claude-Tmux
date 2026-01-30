#!/bin/bash
# Switch between Ralph window and main window
# Called by tmux keybinding Ctrl+b R

SESSION=$(tmux display-message -p '#S')
CURRENT_WINDOW=$(tmux display-message -p '#W')

if [[ "$CURRENT_WINDOW" == "Ralph" ]]; then
    # We're in Ralph, switch to window 1 (main Claude window)
    tmux select-window -t "$SESSION:1"
else
    # We're not in Ralph, try to switch to Ralph window
    if tmux list-windows -t "$SESSION" 2>/dev/null | grep -q "Ralph"; then
        tmux select-window -t "$SESSION:Ralph"
    else
        tmux display-message "No Ralph window. Press Ctrl+b r to launch Ralph."
    fi
fi
