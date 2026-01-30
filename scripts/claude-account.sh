#!/bin/bash
# Current Claude account from pool

STATUS_FILE="$HOME/.claude/.pool-status.json"

if [ -f "$STATUS_FILE" ]; then
    account=$(jq -r '.current // "?"' "$STATUS_FILE" 2>/dev/null)
    case "$account" in
        agentikos) echo "Agtk" ;;
        dafnck) echo "Dfnk" ;;
        *) echo "?" ;;
    esac
else
    echo "?"
fi
