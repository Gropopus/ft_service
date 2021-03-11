FROM alpine:3.13.2

RUN apk update
RUN apk add influxdb

RUN apk add --no-cache openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN openrc >/dev/null 2>&1

COPY /srcs/start.sh /tmp/



EXPOSE 8086
ENTRYPOINT sh /tmp/start.sh
