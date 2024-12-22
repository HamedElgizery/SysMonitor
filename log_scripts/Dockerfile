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
COPY log_cpu_perf /scripts/log_cpu_perf
COPY log_cpu_temp /scripts/log_cpu_temp
COPY log_disk_usage /scripts/log_disk_usage
COPY log_gpu_stats /scripts/log_gpu_stats
COPY log_memory_usage /scripts/log_memory_usage
COPY log_net_stats /scripts/log_net_stats
COPY log_sys_load /scripts/log_sys_load
COPY logger.sh /scripts

RUN chmod +x /scripts/*/*.sh
RUN chmod +x /scripts/*/*.py
RUN chmod +x /scripts/logger.sh

ENTRYPOINT [ "/scripts/logger.sh" ]