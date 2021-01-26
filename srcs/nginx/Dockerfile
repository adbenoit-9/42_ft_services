# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/20 12:49:16 by user42            #+#    #+#              #
#    Updated: 2021/01/26 17:25:56 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.7

RUN apk update && \
    apk add nginx \
    openssh

COPY ./default /etc/nginx/sites-available/
COPY ./nginx.conf /etc/nginx/

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"];
# can't use the cmd "service" it will run nginx in the background and then exit => container will stop

# https://archivengines.wordpress.com/2017/06/16/juste-un-tutoriel-docker/