#!/bin/python3
from sys import argv

uptime_output = argv[1]

load_averages = uptime_output.split("load average: ")[1].split(", ")

print("1-min-average", load_averages[0])
print("5-min-average", load_averages[1])
print("15-min-average", load_averages[2])

