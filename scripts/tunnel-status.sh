#!/bin/bash
# Check if Chrome tunnel (port 9222) is active
if ss -tln 2>/dev/null | grep -q ':9222 '; then
    echo "ON"
else
    echo "OFF"
fi
