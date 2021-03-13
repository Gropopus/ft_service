FROM alpine:3.13.2

RUN apk update
RUN apk add influxdb

RUN apk add telegraf
RUN mkdir -p etc/telegraf/ && mkdir -p /var/log/telegraf-log
RUN touch /var/log/telegraf-log/telegraf.log
COPY ./srcs/telegraf.conf /etc/telegraf/

RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN openrc >/dev/null 2>&1

RUN apk add openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75017/L=Paris/O=42/CN=localhost' -keyout /etc/ssl/private/key.pem -out /etc/ssl/certs/cert.pem >/dev/null 2>&1

COPY /srcs/start.sh /tmp/

EXPOSE 8086
ENTRYPOINT sh /tmp/start.sh
