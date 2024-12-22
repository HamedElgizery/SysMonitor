#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

sys_load_output=$($SCRIPT_DIR/process_uptime.py "$(uptime)")

echo "$sys_load_output" >> /logs/load_logs.txt
echo "$sys_load_output"