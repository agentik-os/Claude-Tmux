#!/bin/bash
# Work Time Tracker - Log session attach/detach events
# Usage: work-tracker.sh [start|stop|heartbeat]

LOG_DIR="$HOME/.tmux/work-tracker/logs"
TODAY=$(date +%Y-%m-%d)
LOG_FILE="$LOG_DIR/$TODAY.log"
STATE_FILE="$HOME/.tmux/work-tracker/current-state"

# Ensure log dir exists
mkdir -p "$LOG_DIR"

ACTION="${1:-heartbeat}"
TIMESTAMP=$(date +%s)
TIME_HUMAN=$(date +%H:%M:%S)

case "$ACTION" in
    start)
        # Session attached - start tracking
        echo "$TIMESTAMP start $TIME_HUMAN" >> "$LOG_FILE"
        echo "$TIMESTAMP" > "$STATE_FILE"
        ;;
    stop)
        # Session detached - stop tracking
        echo "$TIMESTAMP stop $TIME_HUMAN" >> "$LOG_FILE"
        rm -f "$STATE_FILE"
        ;;
    heartbeat)
        # Called every minute to track active time
        # Only log if there's an active session
        if tmux list-sessions 2>/dev/null | grep -q attached; then
            # Check if we need to log a start (new day or first heartbeat)
            if [[ ! -f "$STATE_FILE" ]]; then
                echo "$TIMESTAMP start $TIME_HUMAN" >> "$LOG_FILE"
                echo "$TIMESTAMP" > "$STATE_FILE"
            fi
        else
            # No attached sessions, ensure we logged stop
            if [[ -f "$STATE_FILE" ]]; then
                echo "$TIMESTAMP stop $TIME_HUMAN" >> "$LOG_FILE"
                rm -f "$STATE_FILE"
            fi
        fi
        ;;
esac
