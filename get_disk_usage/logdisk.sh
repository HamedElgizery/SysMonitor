#!/bin/bash

timestamp=$(date +"%Y-%m-%d %H:%M:%S")
log_entry="$timestamp, $(df -h /. | awk '$1 != "Filesystem"')"

echo $log_entry >> logoutput.txt