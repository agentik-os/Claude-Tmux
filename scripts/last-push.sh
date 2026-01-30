#!/bin/bash
# Hours since last push - simplified

# Get session name and find project directory
session=$(tmux display-message -p '#S' 2>/dev/null | sed 's/-[0-9]*$//')

case "$session" in
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
    *) echo "-"; exit 0 ;;
esac

# Check if directory exists and is a git repo
[ ! -d "$dir/.git" ] && { echo "-"; exit 0; }

cd "$dir" || { echo "-"; exit 0; }

# Get current branch
branch=$(git branch --show-current 2>/dev/null)
[ -z "$branch" ] && { echo "-"; exit 0; }

# Get last push timestamp (origin/branch)
last=$(git log -1 --format=%ct "origin/$branch" 2>/dev/null)
[ -z "$last" ] && { echo "-"; exit 0; }

# Calculate hours
now=$(date +%s)
hours=$(( (now - last) / 3600 ))

echo "${hours}h"
