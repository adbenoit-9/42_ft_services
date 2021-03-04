FROM alpine:latest

RUN apk update && apk add influxdb ; \
        apk add ca-certificates

COPY start.sh .

EXPOSE 8086

ENTRYPOINT sh start.sh