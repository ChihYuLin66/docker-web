# FROM nginx:latest
FROM phusion/baseimage:0.11

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Update and Set Default Timezone
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y \
    telnet \
    net-tools \
    iputils-ping \
    ntp
RUN apt install -y wget software-properties-common
RUN echo "Asia/Taipei" > /etc/timezone
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime

# ENABLE SSH
# Ref: https://github.com/phusion/baseimage-docker
# Baseimage-docker disables the SSH server by default. Add the following to
# your Dockerfile to enable it:
RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# NGINX
RUN add-apt-repository ppa:nginx/stable

RUN apt-get update -y && \
    apt-get install -qy curl && \
    apt-get install -qy nginx-full

# Add config files
ADD init /init

ADD cron.d/rotate /etc/cron.d/rotate 
RUN chmod 0644 /etc/cron.d/rotate
RUN touch /var/log/cron.log

# run nginx on startup
ADD my_init.d/01_nginx.sh /etc/my_init.d/01_nginx.sh
ADD root/etc/timezone /etc/timezone
RUN chmod +x /etc/my_init.d/01_nginx.sh

# run init script
RUN chmod +x /init/init.sh
RUN /init/init.sh

CMD ["/sbin/my_init"]

EXPOSE 80
EXPOSE 443