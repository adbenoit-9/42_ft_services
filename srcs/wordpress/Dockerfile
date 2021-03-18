# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/20 12:49:16 by user42            #+#    #+#              #
#    Updated: 2021/01/20 16:36:53 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

ENV ROOT=/usr/share/webapps

RUN apk update && \
    apk add nginx \
    php7 \
    php7-fpm \
    php7-json \
    php7-mysqli \
    php7-cgi \
    fcgi \
    php7-session \
    php7-curl \
    php7-mbstring \
    php7-cli \
    php7-phar \
    mysql-client \
    curl

COPY start.sh .
COPY ./nginx.conf /etc/nginx/
COPY wp-config.php $ROOT/wordpress/

RUN mkdir -p $ROOT/ \
    && mkdir -p /run/nginx \
    && cd $ROOT/ \
    && wget http://wordpress.org/latest.tar.gz \
    && tar -xzvf latest.tar.gz \
    && rm latest.tar.gz \
    && chown -R nginx $ROOT/wordpress \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/bin/wp-cli
    # && sed -i "s/listen = 127.0.0.1:9000/listen = \/run\/php\/php-fpm7.sock/" /etc/php7/php-fpm.d/www.conf
    # && ln -s $ROOT/wordpress/ /var/www/localhost/htdocs/wordpress

EXPOSE 5050

ENTRYPOINT sh start.sh