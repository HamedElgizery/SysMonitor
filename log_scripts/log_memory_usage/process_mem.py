#!/bin/python3
from sys import argv
import time

mem_usage = argv[1]
log_entry = [time.strftime("%Y-%m-%d %H:%M:%S")]  

output = mem_usage.split("\n")
log_entry += [x for x in output if x.strip() != '']

print(",".join(log_entry))