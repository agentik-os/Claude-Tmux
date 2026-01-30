#!/bin/bash
# Work Heartbeat - Runs in background to track active session time
# Checks every 30 seconds if there are attached sessions

TRACKER="$HOME/.tmux/scripts/work-tracker.sh"

while true; do
    "$TRACKER" heartbeat
    sleep 30
done
