# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adbenoit <adbenoit@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/01 15:07:33 by adbenoit          #+#    #+#              #
#    Updated: 2021/04/01 15:07:35 by adbenoit         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

RUN wget https://dl.grafana.com/oss/release/grafana-7.2.1.linux-amd64.tar.gz ; \
    tar xzvf grafana-7.2.1.linux-amd64.tar.gz ; \
    mv grafana-7.2.1 grafana ; \
	rm grafana-7.2.1.linux-amd64.tar.gz

RUN apk add --no-cache libc6-compat

COPY grafana.db /grafana/data/

EXPOSE 3000

CMD cd /grafana/bin ; \
        ./grafana-server
