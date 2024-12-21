#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

cpu_output=$($SCRIPT_DIR/process_cpu.py "$(mpstat -o JSON)")

echo "$cpu_output" >> /logs/cpu_logs.txt
echo "$cpu_output"
