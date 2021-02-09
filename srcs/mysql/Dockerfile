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

ENV ROOT=/var/www/html

COPY latest.tar.gz /tmp/

RUN tar -xzvf /tmp/latest.tar.gz -C $ROOT/ \
    && chown -R www-data:www-data $ROOT/wordpress

EXPOSE 5050

ENTRYPOINT echo '\033[34mWorpress \033[0m[\033[32mOK\033[0m]'
