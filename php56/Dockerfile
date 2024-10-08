FROM phusion/baseimage:jammy-1.0.1

# Default baseimage settings
ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]
ENV DEBIAN_FRONTEND noninteractive

####################################
# Update and install network tools, set system default timezone
####################################
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

####################################
# Create normal group and user 
####################################
ARG PHP_NORMAL_USER 
ENV PHP_NORMAL_USER=${PHP_NORMAL_USER}
ARG PHP_NORMAL_GROUP 
ENV PHP_NORMAL_GROUP=${PHP_NORMAL_GROUP}

RUN groupadd -g 1000 ${PHP_NORMAL_GROUP}
RUN useradd -d /home/${PHP_NORMAL_USER} -g ${PHP_NORMAL_GROUP} -s /bin/bash ${PHP_NORMAL_USER}

# copy root .bashrc file for normal user 
COPY /init/.bashrc /home/${PHP_NORMAL_USER}/.bashrc

####################################
# Install php 5.6 tool 
####################################
# Add the PPA for PHP 5.6
RUN add-apt-repository ppa:ondrej/php

# Update software list and install php 
RUN apt-get update \
    && apt-get install -y \ 
    php5.6-fpm \
    php5.6-common \
    php5.6-mysql \
    php5.6-xml \
    php5.6-xmlrpc \
    php5.6-curl \
    php5.6-gd \
    php5.6-imagick \
    php5.6-cli \
    php5.6-dev \
    php5.6-imap \
    php5.6-mbstring \
    php5.6-opcache \
    php5.6-soap \
    php5.6-zip \
    unzip

# Global setting
WORKDIR /var/www

####################################
# Install composer tool 
####################################
RUN curl -s https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
RUN apt-get update && apt install unzip && apt-get clean && rm -rf /var/lib/apt/lists/*

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

####################################
# Install Nodejs, npm, nvm
####################################
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash 
RUN export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" && \
     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
     nvm install 12.22.1 && \
     nvm use 12.22.1

# Clear cache
RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  /tmp/* \
  /var/tmp/*

# Add config files
ADD init /init

# run init script
RUN chmod +x /init/init.sh
RUN /init/init.sh

# run PHP5.6-fpm on startup
ADD my_init.d/03_php56.sh /etc/my_init.d/03_php56.sh
RUN chmod +x /etc/my_init.d/03_php56.sh

# clear cache.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# CMD ["php56-fpm"]