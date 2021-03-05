FROM alpine:latest

RUN apk update && apk add influxdb ; \
        apk add ca-certificates

COPY start.sh .
# COPY influxdb.conf etc/

EXPOSE 8086

ENTRYPOINT sh start.sh