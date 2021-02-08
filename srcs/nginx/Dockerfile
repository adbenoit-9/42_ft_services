# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adbenoit <adbenoit@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/20 12:49:16 by user42            #+#    #+#              #
#    Updated: 2021/02/01 13:26:25 by adbenoit         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

RUN apk update && \
    apk add nginx \
    openssl \
    bash

COPY ./nginx.conf /etc/nginx/

RUN openssl req -x509 -out etc/nginx/nginx.crt \
        -keyout etc/nginx/nginx.key -newkey rsa:2048 -nodes -sha256 \
        -subj '/CN=nginx' \
    && echo '[ \033[32mok\033[0m ] Generating a RSA private key'

RUN mkdir -p /run/nginx

EXPOSE 80 443

# CMD ["bash"]
CMD ["nginx", "-g", "daemon off;"];
# can't use the cmd "service" it will run nginx in the background and then exit 
# => container will stop
