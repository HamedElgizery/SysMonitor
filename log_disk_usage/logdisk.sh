#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

log_entry="$(df -h /. | awk '$1 != "Filesystem"')"


$SCRIPT_DIR/process_disk_log.py "$log_entry" >> logoutput.txt
