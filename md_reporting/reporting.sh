#!/bin/bash

LOG_DIR="/scripts"

while true; do
    timestamp=$(date +%s)
    echo $timestamp
    ./generate_report.py $timestamp
  sleep 10
done


