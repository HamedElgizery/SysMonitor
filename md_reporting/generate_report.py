#!/usr/bin/env python3

from sys import argv
from mdutils.mdutils import MdUtils
from datetime import datetime

report_name = str(argv[1])
# Read data from shared docker volume

def get_cpu_temp():
    return str(30) + u"C\N{DEGREE SIGN}"
def get_gpu_status():
    return None 
def get_net_stats():
    pass
def get_cpu_perf():
    return (2, 2, ["Metric", "Value", "USR", "1.4"])
def get_disk_usage():
    pass
def get_memory_usage():
    pass
def get_sys_load():
    pass



def add_section(report_file, content, title):
    report_file.new_header(level=2, title=title)
    report_file.new_table(columns=content[0], rows=content[1], text=content[2], text_align='center')
    
report_file = MdUtils(file_name=report_name, title="Report {}".format(report_name))
report_file.new_header(level=1, title="System Stats {}".format(datetime.fromtimestamp(1284286794)))
add_section(report_file, get_cpu_perf(), title="CPU Stats ({})".format(get_cpu_temp()))
add_section(report_file, get_cpu_perf(), title="GPU Stats")
add_section(report_file, get_cpu_perf(), title="Network Stats")
add_section(report_file, get_cpu_perf(), title="Disk Stats")
add_section(report_file, get_cpu_perf(), title="Memory Stats")
add_section(report_file, get_cpu_perf(), title="Sys Load Metrics")
report_file.new_table_of_contents(table_title='Contents', depth=2)
report_file.create_md_file()
