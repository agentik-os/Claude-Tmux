#!/bin/bash
# Count Claude Code background tasks/agents
# Counts Task tool subagents running in background
count=$(ps aux 2>/dev/null | grep -E "claude.*--background|claude.*task" | grep -v grep | wc -l)
echo "$count"
