# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/20 12:49:16 by user42            #+#    #+#              #
#    Updated: 2021/01/22 15:13:39 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.7

ENV ROOT=/var/www/html

RUN apt-get update -y && \
    apt-get install nginx \
    openssl \
    -y

COPY srcs/default /etc/nginx/sites-available/
COPY srcs/nginx.conf /etc/nginx/

EXPOSE 80 443

ENTRYPOINT  service nginx start \
            && echo '\033[34mNginx \033[0m[\033[32mOK\033[0m]'
