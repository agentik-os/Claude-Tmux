#!/bin/bash
# Ralph status - returns " · 🤖 project" if active, empty if not

# Compter les sessions Ralph (tmux sessions nommées "Ralph-*")
ralph_count=$(tmux ls 2>/dev/null | grep -c "^Ralph-")
ralph_count=${ralph_count:-0}

# Compter les processus ralph_loop.sh (utilise [r] pour éviter l'auto-match de pgrep)
ralph_procs=$(pgrep -c -f "[r]alph_loop.sh" 2>/dev/null)
ralph_procs=${ralph_procs:-0}

# Afficher seulement si Ralph est actif
if [ "$ralph_count" -gt 0 ] || [ "$ralph_procs" -gt 0 ]; then
    if [ "$ralph_count" -eq 1 ]; then
        project=$(tmux ls 2>/dev/null | grep "^Ralph-" | head -1 | cut -d: -f1 | sed 's/Ralph-//')
        echo " · 🤖 $project"
    elif [ "$ralph_count" -gt 1 ]; then
        echo " · 🤖 $ralph_count"
    else
        echo " · 🤖"
    fi
fi
