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
    php7-fpm \
    php7-opcache \
    php7-common \
    php7-iconv \
    php7-json \
    php7-gd \
    php7-mysqli \
    php7-imap \
    php7-cgi \
    fcgi \
    php7-pdo \
    php7-pdo_mysql \
    php7-soap \
    php7-xmlrpc \
    php7-posix \
    php7-session \
    php7-mcrypt \
    php7-gettext \
    php7-ldap \
    php7-ctype \
    php7-dom \
    php7-curl \
    php7-xml \
    php7-mbstring \
    mysql-client \
    curl


COPY start.sh .
COPY ./nginx.conf /etc/nginx/

RUN mkdir -p $ROOT/ \
    && mkdir -p /run/nginx \
    && cd $ROOT/ \
    # && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    # && chmod +x wp-cli.phar \
    # && mv wp-cli.phar /usr/bin/wp-cli \
    # && chown nginx:nginx /usr/bin/wp-cli
    && wget http://wordpress.org/latest.tar.gz \
    && tar -xzvf latest.tar.gz \
    && rm latest.tar.gz \
    && chown -R nginx $ROOT/ \
    && ln -s $ROOT/wordpress/ /var/www/localhost/htdocs/wordpress

COPY wp-config-sample.php $ROOT/wordpress/

EXPOSE 5050

ENTRYPOINT sh start.sh