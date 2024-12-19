FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    sudo \
    lm-sensors \
    smartmontools \
    sysstat \
    iproute2 \
    python3 \
    python3-pip \
    python3-venv 


RUN yes "" | sudo sensors-detect || true

WORKDIR /scripts
COPY get_cpu_perf /scripts/get_cpu_perf
COPY get_cpu_temp /scripts/get_cpu_temp
COPY get_disk_usage /scripts/get_disk_usage
COPY get_gpu_stats /scripts/get_gpu_stats
COPY get_memory_usage /scripts/get_memory_usage
COPY get_net_stats /scripts/get_net_stats
COPY get_sys_load /scripts/get_sys_load

RUN chmod +x /scripts/*/*.sh
RUN chmod +x /scripts/*/*.py

