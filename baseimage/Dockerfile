# set the base image first
FROM phusion/baseimage:0.11

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive



RUN apt-get update && apt-get -y upgrade
RUN apt install -y wget software-properties-common
RUN echo "Asia/Taipei" > /etc/timezone
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime

# ENABLE SSH
# Ref: https://github.com/phusion/baseimage-docker
# Baseimage-docker disables the SSH server by default. Add the following to your Dockerfile to enable it:
RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
# RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

