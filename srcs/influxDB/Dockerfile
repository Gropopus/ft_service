FROM alpine:3.13.2

RUN apk update
RUN apk add influxdb
COPY /srcs/start.sh /tmp/

EXPOSE 8086
ENTRYPOINT sh /tmp/start.sh
