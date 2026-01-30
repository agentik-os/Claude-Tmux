#!/bin/bash
# Ralph status for tmux status bar
# Shows: running count, or nothing if no Ralph sessions

# Count Ralph tmux sessions
ralph_count=$(tmux ls 2>/dev/null | grep -c "^Ralph-")
ralph_count=${ralph_count:-0}

# Check for active Ralph processes
ralph_procs=$(pgrep -cf "ralph_loop.sh" 2>/dev/null)
ralph_procs=${ralph_procs:-0}

# Determine if anything is running
if [ "$ralph_count" -gt 0 ] 2>/dev/null || [ "$ralph_procs" -gt 0 ] 2>/dev/null; then
    # Get the project name if only one Ralph session
    if [ "$ralph_count" -eq 1 ] 2>/dev/null; then
        project=$(tmux ls 2>/dev/null | grep "^Ralph-" | cut -d: -f1 | sed 's/Ralph-//')
        echo "🤖$project"
    elif [ "$ralph_count" -gt 1 ] 2>/dev/null; then
        echo "🤖$ralph_count"
    else
        echo "🤖"
    fi
fi
