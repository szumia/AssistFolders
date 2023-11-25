# syntax=docker/dockerfile:1
FROM ubuntu:20.04
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY . /home/
RUN /bin/bash -c "chmod 777 /home/*; cd /home; change_source.sh; infantry-depens-install.sh <<< "y""


