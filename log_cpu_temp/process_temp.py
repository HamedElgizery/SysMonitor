#!/bin/python3
from sys import argv
import time

cpu_temp = argv[1]
log_entry = [time.strftime("%Y-%m-%d %H:%M:%S")]  

output = cpu_temp.split("\n")
log_entry += [x.split(" ")[1] for x in output if x.strip() != '']

print(",".join(log_entry))