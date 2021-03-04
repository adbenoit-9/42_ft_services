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

RUN apk add vsftpd openssl

COPY start.sh .
COPY vsftpd.conf etc/vsftpd/

RUN mkdir -p /etc/ssl/private \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout \
    /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj '/CN=192.168.49.2'

EXPOSE 21 30000

ENTRYPOINT sh start.sh
