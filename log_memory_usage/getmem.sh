#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

mem_result=$(awk '/MemTotal|MemFree|Buffers|Cached|SwapTotal|SwapFree|Active|Inactive|Available|Slab|Committed_AS|HighTotal|HighFree/ {print $2}' /proc/meminfo)

mem_output=$($SCRIPT_DIR/process_mem.py "$mem_result")

echo "$mem_output" >> /logs/mem_logs.txt
echo "$mem_output"