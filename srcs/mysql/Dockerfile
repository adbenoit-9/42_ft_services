# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adbenoit <adbenoit@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/01 15:07:58 by adbenoit          #+#    #+#              #
#    Updated: 2021/04/01 15:07:59 by adbenoit         ###   ########.fr        #
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
