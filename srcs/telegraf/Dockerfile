FROM alpine:latest

COPY telegraf.conf etc/telegraf/

ADD  https://dl.influxdata.com/telegraf/releases/telegraf-1.14.0-static_linux_amd64.tar.gz ./

RUN tar xf telegraf-1.14.0-static_linux_amd64.tar.gz \
    && chmod +x telegraf/* \
    && cp telegraf/telegraf /usr/bin/ \
    && mv telegraf /etc/telegraf \
	&& rm -rf *.tar.gz*

RUN apk add libc6-compat

ENTRYPOINT telegraf