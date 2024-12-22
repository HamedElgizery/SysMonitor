#!/bin/bash

# Need lm-sensor installed 
# sudo apt install lm-sensors
# Need to scan the sensors after
# sudo sensors-detect
SCRIPT_DIR="$(dirname "$0")"


cpu_temp=$(sensors | awk '/Core/{print $1 "-" substr($2, 1, length($2)-1) " " $3}')

cpu_temp_output=$($SCRIPT_DIR/process_temp.py "$cpu_temp")

echo "$cpu_temp_output" >> /logs/cpu_temp_logs.txt
echo "$cpu_temp_output"