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

# COPY grafana.db /grafana/data/grafana.db

RUN apk add --no-cache libc6-compat

ADD https://dl.grafana.com/oss/release/grafana-7.2.1.linux-amd64.tar.gz ./

RUN tar -zxvf grafana-7.2.1.linux-amd64.tar.gz \
    && mv grafana-7.2.1 grafana 

EXPOSE 3000

ENTRYPOINT cd  /grafana/bin/ && ./grafana-server
