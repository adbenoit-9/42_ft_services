# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adbenoit <adbenoit@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/01 15:07:43 by adbenoit          #+#    #+#              #
#    Updated: 2021/04/01 15:07:44 by adbenoit         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

RUN apk update && apk add influxdb ; \
        apk add ca-certificates

COPY start.sh .

EXPOSE 8086

ENTRYPOINT sh start.sh