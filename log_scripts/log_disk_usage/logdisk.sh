#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

log_entry="$(df -h /. | awk '$1 != "Filesystem"')"

disk_output=$($SCRIPT_DIR/process_disk_log.py "$log_entry")

echo "$disk_output" >> /logs/disk_logs.txt
echo "$disk_output"