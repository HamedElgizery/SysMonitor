#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

$SCRIPT_DIR/process_uptime.py "$(uptime)" >> logoutput.txt
