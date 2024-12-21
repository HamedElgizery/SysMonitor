#!/bin/bash

LOG_DIR="/scripts"

while true; do
  for dir in log*/; do
      if [ -d "$dir" ]; then
        for script in "$dir"*.sh; do
            if [ -f "$script" ]; then
                timestamp=$(date +%s).md
                ./generate_report.py $timestamp
            fi
        done
      fi
    done
  sleep 10
done


