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

RUN apk add mariadb mariadb-client

COPY start.sh .

COPY mariadb-server.cnf /etc/my.cnf.d/
COPY config.sql .

RUN chmod 777 start.sh \
    && mkdir -p /run/mysqld \
    && chown mysql /var/lib/mysql

ENTRYPOINT sh start.sh
