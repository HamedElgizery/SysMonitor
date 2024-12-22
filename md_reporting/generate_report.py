#!/usr/bin/env python3

from sys import argv
from mdutils.mdutils import MdUtils
from datetime import datetime
import os

report_name = "/reports/"+str(argv[1])
LOG_DIR = "/logs/"

# Read data from shared docker volume

def get_cpu_temp():
    #TODO: Change txt to log
    LOG_FILE = os.path.join(LOG_DIR, "cpu_temp_logs.txt")
    with open(LOG_FILE) as f:
        line = None
        for line in f:
            pass
        last_line = line
    content = ["Core#", "Temperature"]
    values = last_line.split(',')[1:]
    for i in range(len(values)):
        content.extend(["Core " + str(i), values[i]])
    return (2, len(values) + 1, content)

def get_gpu_status():
    return None 

def get_net_stats():
    LOG_FILE = os.path.join(LOG_DIR, "net_logs.txt")
    lines = []
    with open(LOG_FILE) as f:
        vis_dev = set()
        cnt = 0
        add = 1
        for line in f:
            lines.append(line)
            dev = line.split(',')[1]
            if dev in vis_dev:
                print("HER")
                add = 0
            print(add)
            vis_dev.add(dev)
            cnt+=add
    print(cnt)
    content = ["Interface", "RBytes", "RPackets", "Rerrs", "RDropped", "ROver Errs", "RMutlicast", "TBytes", "TPackets", "TErrs", "TDropped", "TCarrier Errs", "TCollisions"]
    for i in range(1, cnt + 1):
        values = lines[-i].split(',')[1:]
        for j in range(len(values)):
            content.append(values[j])
    print(content)
    return (len(values), cnt + 1, content)

def get_cpu_perf():
    LOG_FILE = os.path.join(LOG_DIR, "cpu_logs.txt")
    with open(LOG_FILE) as f:
        line = None
        for line in f:
            pass
        last_line = line
    fields = ["USR", "NICE", "SYS", "IOWAIT", "IRQ", "SOFT", "STEAL", "GUEST", "GNICE", "IDLE"]
    content = ["Metric", "Value"]
    values = last_line.split(',')[1:]
    for i in range(len(values)):
        content.extend([fields[i], values[i]])
    return (2, len(values) + 1, content)
def get_disk_usage():
    LOG_FILE = os.path.join(LOG_DIR, "disk_logs.txt")
    with open(LOG_FILE) as f:
        line = None
        for line in f:
            pass
        last_line = line
    content = ["Disk Name", "Total Space", "Used Space", "Free Space", "Used Percentage", "Smart Status"]
    values = last_line.split(',')[1:]
    for i in range(len(values)):
        content.append(values[i])
    # TODO: Implement to support multiple disks
    # needs to be suported first in the log files
    # TODO: Fix logging smart status
    return (len(values), 2, content)

def get_memory_usage():
    LOG_FILE = os.path.join(LOG_DIR, "mem_logs.txt")
    with open(LOG_FILE) as f:
        line = None
        for line in f:
            pass
        last_line = line
    fields = ["MemTotal", "MemFree", "MemAvailable", "Buffers", "Cached", "SwapCached", "Active", "Inactive", "Active(anon)", "Inactive(anon)", "Active(file)", "Inactive(file)", "SwapTotal", "SwapFree", "Slab", "Committed_AS"]
    content = ["Metric", "Value"]
    values = last_line.split(',')[1:]
    for i in range(len(values)):
        content.extend([fields[i], values[i]])
    return (2, len(values) + 1, content)

def get_sys_load():
    LOG_FILE = os.path.join(LOG_DIR, "load_logs.txt")
    with open(LOG_FILE) as f:
        line = None
        for line in f:
            pass
        last_line = line
    fields = ["1-min-average", "5-min-average", "15-min-average"]
    content = ["Duration", "Value"]
    values = last_line.split(',')[1:]
    for i in range(len(values)):
        content.extend([fields[i], values[i]])
    return (2, len(values) + 1, content)



def add_section(report_file, content, title):
    report_file.new_header(level=2, title=title)
    report_file.new_table(columns=content[0], rows=content[1], text=content[2], text_align='center')

print("EHEREE")
report_file = MdUtils(file_name=report_name, title="Report {}".format(report_name))
report_file.new_header(level=1, title="System Stats {}".format(datetime.fromtimestamp(1284286794)))
add_section(report_file, get_cpu_temp(), title="CPU Temperature")
add_section(report_file, get_cpu_perf(), title="CPU Stats")
add_section(report_file, get_cpu_perf(), title="GPU Stats")
add_section(report_file, get_net_stats(), title="Network Stats")
add_section(report_file, get_disk_usage(), title="Disk Stats")
add_section(report_file, get_memory_usage(), title="Memory Stats")
add_section(report_file, get_sys_load(), title="Sys Load Metrics")
report_file.new_table_of_contents(table_title='Contents', depth=2)
report_file.create_md_file()
