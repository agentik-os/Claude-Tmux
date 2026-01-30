#!/bin/bash
# Tunnel status based on current project directory

PWD_PATH="$(tmux display-message -p '#{pane_current_path}' 2>/dev/null)"

case "$PWD_PATH" in
    */Gluten-Libre*|*/gluten*)
        PORT=9224; PROJECT="Gluten" ;;
    */DentistryGPT*|*/dentist*)
        PORT=9225; PROJECT="Dentist" ;;
    */agentic-os/*|*/agentik*|*/Agentik*)
        PORT=9226; PROJECT="Agentik" ;;
    */kommu*|*/Kommu*)
        PORT=9227; PROJECT="Kommu" ;;
    */DevLensPro*|*/devlens*)
        PORT=9228; PROJECT="DevLens" ;;
    */VibeCoding/work/*)
        # Work folder - Simono ou Dafnck
        if ss -tln 2>/dev/null | grep -q "127.0.0.1:9222 "; then
            echo "Simono ON"; exit 0
        elif ss -tln 2>/dev/null | grep -q "127.0.0.1:9223 "; then
            echo "Dafnck ON"; exit 0
        else
            echo "Work OFF"; exit 0
        fi ;;
    *)
        # Home - count unique ports
        COUNT=$(ss -tln 2>/dev/null | grep "127.0.0.1:922" | wc -l)
        [ "$COUNT" -gt 0 ] && echo "$COUNT tunnels" || echo "OFF"
        exit 0 ;;
esac

# Check specific port
if ss -tln 2>/dev/null | grep -q "127.0.0.1:$PORT "; then
    echo "$PROJECT ON"
else
    echo "$PROJECT OFF"
fi
