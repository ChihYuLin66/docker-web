#!/bin/bash

echo Setting PHP INI File

# mv /etc/php/7.3/fpm/php.ini /etc/php/7.3/fpm/php.ini.default
# cp /init/php.ini /etc/php/7.3/fpm/php.ini

echo Setting PHP FPM File

mv /etc/php/7.3/fpm/pool.d/www.conf /etc/php/7.3/fpm/pool.d/www.conf.default
cp /init/pools/main.conf /etc/php/7.3/fpm/pool.d/www.conf

