#!/bin/bash

 ./process_cpu.py "$(mpstat -o JSON)" > cpu_perf.txt
