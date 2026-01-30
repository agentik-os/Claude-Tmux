#!/bin/bash
# Time since last git push for the session's project
session_name=$(tmux display-message -p '#S' 2>/dev/null | sed 's/-[0-9]*$//')

case "$session_name" in
    Home) dir="/home/hacker" ;;
    Kommu) dir="/home/hacker/VibeCoding/work/kommu" ;;
    DentistryGPT) dir="/home/hacker/VibeCoding/clients/DentistryGPT" ;;
    Gluten) dir="/home/hacker/VibeCoding/clients/Gluten-Libre" ;;
    DevLens) dir="/home/hacker/VibeCoding/work/DevLensPro" ;;
    LifePixels) dir="/home/hacker/VibeCoding/agentic-os/LifePixels/App" ;;
    SagaForge) dir="/home/hacker/VibeCoding/agentic-os/SagaForge" ;;
    Vision) dir="/home/hacker/VibeCoding/agentic-os/vision" ;;
    AgentikDev) dir="/home/hacker/VibeCoding/agentic-os/AgentikDev" ;;
    Formation) dir="/home/hacker/VibeCoding/work/Formation-AI" ;;
    Resonant) dir="/home/hacker/VibeCoding/clients/resonant" ;;
    *) dir="/home/hacker" ;;
esac

# Get timestamp of last commit on remote tracking branch
last_push=$(git -C "$dir" log -1 --format=%ct origin/$(git -C "$dir" branch --show-current 2>/dev/null) 2>/dev/null)

if [ -n "$last_push" ]; then
    now=$(date +%s)
    diff=$((now - last_push))

    if [ $diff -lt 60 ]; then
        echo "${diff}s"
    elif [ $diff -lt 3600 ]; then
        echo "$((diff/60))m"
    elif [ $diff -lt 86400 ]; then
        echo "$((diff/3600))h"
    else
        echo "$((diff/86400))d"
    fi
else
    echo "-"
fi
