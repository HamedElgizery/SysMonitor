#!/bin/python3
from sys import argv
import time

disk_data = argv[1]
log_entry = [time.strftime("%Y-%m-%d %H:%M:%S")]  

output = disk_data.split(" ")
log_entry += [x for x in output if x.strip() != '']

print(",".join(log_entry))