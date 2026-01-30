#!/bin/bash
# Work Time Display - Shows today's work time only
# Resets at midnight. Format: "5h32" or "45m"

LOG_DIR="$HOME/.tmux/work-tracker/logs"
TODAY=$(date +%Y-%m-%d)
LOG_FILE="$LOG_DIR/$TODAY.log"

# Function to format seconds as Xh:Xm
format_time() {
    local seconds=$1
    local hours=$((seconds / 3600))
    local minutes=$(((seconds % 3600) / 60))

    if [[ $hours -gt 0 ]]; then
        printf "%dh%02d" $hours $minutes
    else
        printf "%dm" $minutes
    fi
}

# Calculate work time from today's log file
calc_day_time() {
    local file="$1"
    local total=0
    local start_time=0
    local in_session=false

    [[ ! -f "$file" ]] && echo 0 && return

    while read -r timestamp action _; do
        [[ -z "$timestamp" ]] && continue

        if [[ "$action" == "start" ]]; then
            start_time=$timestamp
            in_session=true
        elif [[ "$action" == "stop" && "$in_session" == true ]]; then
            total=$((total + timestamp - start_time))
            in_session=false
        fi
    done < "$file"

    # If still in session, add time until now
    if [[ "$in_session" == true && $start_time -gt 0 ]]; then
        local now=$(date +%s)
        total=$((total + now - start_time))
    fi

    echo $total
}

# Calculate and format today's work time
today_seconds=$(calc_day_time "$LOG_FILE")
format_time $today_seconds
