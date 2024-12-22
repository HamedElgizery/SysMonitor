#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

log_net_output=$($SCRIPT_DIR/process_net.py "$(ip -s -j link)")

echo "$log_net_output" >> /logs/net_logs.txt
echo "$log_net_output"
