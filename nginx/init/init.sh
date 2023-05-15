
echo Setting up nginx root directory

# [[ -d /var/www ]] || mkdir /var/www
# cp /init/index.html /var/www/
# cp /init/default-host /etc/nginx/sites-enabled/default

chown -R www-data:www-data /var/www

sed -i 's/# server_names_hash_bucket_size 64;$/server_names_hash_bucket_size 64;/g' /etc/nginx/nginx.conf

