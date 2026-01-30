#!/bin/bash
# Prompt Counter - Shows today's prompts and total since beginning
# Format: "85 (1.3k)" = 85 today, 1300 total

HISTORY_FILE="$HOME/.claude/history.jsonl"

if [[ ! -f "$HISTORY_FILE" ]]; then
    echo "0"
    exit 0
fi

# Get today's start timestamp (midnight) in milliseconds
TODAY_START=$(date -d "today 00:00:00" +%s 2>/dev/null || date -v0H -v0M -v0S +%s 2>/dev/null)
TODAY_START_MS=$((TODAY_START * 1000))

# Count today's prompts
TODAY_COUNT=$(awk -F'"timestamp":' -v start="$TODAY_START_MS" '
    NF > 1 {
        split($2, a, ",")
        ts = a[1]
        gsub(/[^0-9]/, "", ts)
        if (ts >= start) count++
    }
    END { print count + 0 }
' "$HISTORY_FILE")

# Count total prompts (fast: just count lines)
TOTAL=$(wc -l < "$HISTORY_FILE" | tr -d ' ')

# Format total (1.3k if > 1000)
if [[ $TOTAL -ge 1000 ]]; then
    TOTAL_FMT=$(awk "BEGIN {printf \"%.1fk\", $TOTAL/1000}")
else
    TOTAL_FMT=$TOTAL
fi

echo "$TODAY_COUNT ($TOTAL_FMT)"
