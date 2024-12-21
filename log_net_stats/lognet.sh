#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

$SCRIPT_DIR/process_net.py "$(ip -s -j link)" >> logoutput.txt
