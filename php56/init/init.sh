#!/bin/bash

echo Setting PHP56 INI File

# mv /etc/php/5.6/fpm/php.ini /etc/php/5.6/fpm/php.ini.default
cp /init/php.ini /etc/php/5.6/fpm/php.ini

echo Setting PHP FPM File

mv /etc/php/5.6/fpm/pool.d/www.conf /etc/php/5.6/fpm/pool.d/www.conf.default
cp /init/pools/main.conf /etc/php/5.6/fpm/pool.d/www.conf

