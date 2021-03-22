#!/bin/bash

php-fpm7
wp-cli --allow-root core install --path=/usr/share/webapps/wordpress --url=http://192.168.49.2:5050 \
--title="ft_services" --admin_user=user42 --admin_password=user42 --admin_email=xxx@xxx.fr
nginx -g "daemon off;"
