#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

$SCRIPT_DIR/process_cpu.py "$(mpstat -o JSON)"
