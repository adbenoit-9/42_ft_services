# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/20 12:49:16 by user42            #+#    #+#              #
#    Updated: 2021/02/01 11:30:35 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

RUN apk update && \
    apk add nginx \
    openssl \
    bash

COPY ./default /etc/nginx/sites-available/
COPY ./nginx.conf /etc/nginx/

RUN openssl req -x509 -out etc/nginx/localhost.crt \
        -keyout etc/nginx/localhost.key -newkey rsa:2048 -nodes -sha256 \
        -subj '/CN=localhost' \
    && echo '[ \033[32mok\033[0m ] Generating a RSA private key'

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"];
# can't use the cmd "service" it will run nginx in the background and then exit => container will stop
