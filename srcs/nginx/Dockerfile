# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/20 12:49:16 by user42            #+#    #+#              #
#    Updated: 2021/01/25 15:55:53 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.7

RUN apk update && \
    apk add nginx \
    openssl

COPY ./default /etc/nginx/sites-available/
COPY ./nginx.conf /etc/nginx/

EXPOSE 80 443

# ENTRYPOINT  bash
            # service nginx start \
            # && echo '\033[34mNginx \033[0m[\033[32mOK\033[0m]'
