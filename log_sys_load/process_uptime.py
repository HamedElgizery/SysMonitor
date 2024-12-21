#!/bin/python3
from sys import argv
import time

uptime_output = argv[1]

load_averages = uptime_output.split("load average: ")[1].split(", ")
time_now = time.strftime("%Y-%m-%d %H:%M:%S")  

print(",".join([time_now] + [str(item) for item in load_averages]))

