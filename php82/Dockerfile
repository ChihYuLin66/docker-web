FROM phusion/baseimage:0.11



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
# Install php 8.2 tool and initial global config 
####################################
# Initial php8.2 use node version
ARG PHP82_NODE_VERSION 
ENV PHP82_NODE_VERSION=${PHP82_NODE_VERSION}

# Install few packages before add PPA tool
# RUN apt-get install -y lsb-release gnupg2 ca-certificates apt-transport-https software-properties-common
RUN apt-get update \
    && apt-get install -y gnupg gosu ca-certificates supervisor sqlite3 libcap2-bin libpng-dev

# Add the PPA for PHP 8.2
RUN add-apt-repository ppa:ondrej/php

# Update software list and install php 
RUN apt-get update \
    && apt-get install -y \ 
    php8.2 \
    php8.2-fpm \
    php8.2-common \
    php8.2-mysql \
    php8.2-xml \
    php8.2-xmlrpc \
    php8.2-curl \
    php8.2-gd \
    php8.2-imagick \
    php8.2-cli \
    php8.2-dev \
    php8.2-imap \
    php8.2-mbstring \
    php8.2-opcache \
    php8.2-soap \
    php8.2-zip \
    php8.2-bcmath \
    php8.2-msgpack \
    php8.2-igbinary \
    php8.2-redis \
    php8.2-swoole \
    php8.2-memcached \
    php8.2-pcov \
    php8.2-xdebug \
    unzip

# Global setting
WORKDIR /var/www

####################################
# Install composer tool 
####################################
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
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
     nvm install "${PHP82_NODE_VERSION}" && \
     nvm use "${PHP82_NODE_VERSION}"

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

# run PHP8.2-fpm on startup
ADD my_init.d/03_php82.sh /etc/my_init.d/03_php82.sh
RUN chmod +x /etc/my_init.d/03_php82.sh

# clear cache.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# CMD ["php82-fpm"]