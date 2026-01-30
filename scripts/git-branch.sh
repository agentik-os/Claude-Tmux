#!/bin/bash
# Get current git branch for the session's project
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

branch=$(git -C "$dir" branch --show-current 2>/dev/null)
# Affiche "· branchname" ou rien
[ -n "$branch" ] && echo "· $branch"
