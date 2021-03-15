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

RUN apk update && apk upgrade \
    && apk add grafana

ENV PATH=/usr/share/grafana/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
    GF_PATHS_DATA="/var/lib/grafana" \
    GF_PATHS_HOME="/usr/share/grafana" \
    GF_PATHS_LOGS="/var/log/grafana" \
    GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
    GF_PATHS_PROVISIONING="/etc/grafana/provisioning"

RUN mkdir -p "$GF_PATHS_HOME" \
    && mkdir -p "$GF_PATHS_PROVISIONING/datasources" \
        "$GF_PATHS_PROVISIONING/dashboards" \
        "$GF_PATHS_PROVISIONING/notifiers" \
        "$GF_PATHS_LOGS" \
        "$GF_PATHS_PLUGINS" \
        "$GF_PATHS_DATA" \
    && chown -R grafana:grafana "$GF_PATHS_DATA" "$GF_PATHS_HOME" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING" \
    && chmod -R 777 "$GF_PATHS_DATA" "$GF_PATHS_HOME" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING"

# COPY grafana.db .

# RUN apk add --no-cache libc6-compat

# ADD https://dl.grafana.com/oss/release/grafana-7.2.1.linux-amd64.tar.gz ./

# RUN tar -zxvf grafana-7.2.1.linux-amd64.tar.gz \
#     && mv grafana-7.2.1 grafana 

EXPOSE 3000

ENTRYPOINT grafana-server
