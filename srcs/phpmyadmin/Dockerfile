# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adbenoit <adbenoit@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/01 15:08:32 by adbenoit          #+#    #+#              #
#    Updated: 2021/04/01 15:08:33 by adbenoit         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

RUN apk update && \
    apk add nginx \
    php7 \
    php7-fpm \
    php7-json \
    php7-mysqli \
    php7-session \
    php7-curl \
    php7-mbstring

COPY start.sh .
COPY ./nginx.conf /etc/nginx/
COPY config.inc.php /usr/share/webapps/phpmyadmin/

RUN mkdir -p /usr/share/webapps/ \
    && mkdir -p /run/nginx \
    && cd /usr/share/webapps \
    && wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
    && tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
    && rm phpMyAdmin-5.0.2-all-languages.tar.gz \
    && mv phpMyAdmin-5.0.2-all-languages/* phpmyadmin \
    && chmod -R 777 /usr/share/webapps/ \
    && chmod 544 /usr/share/webapps/phpmyadmin/config.inc.php

EXPOSE 5000

ENTRYPOINT sh start.sh
