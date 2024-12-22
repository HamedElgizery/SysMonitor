FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    sudo \
    python3 \
    python3-pip \
    python3-venv

RUN pip install mdutils
RUN mkdir /reports
WORKDIR /scripts
COPY generate_report.py /scripts/
COPY reporting.sh /scripts

RUN chmod +x /scripts/*

ENTRYPOINT [ "/scripts/reporting.sh" ]

