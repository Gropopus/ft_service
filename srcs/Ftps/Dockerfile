FROM alpine:3.13.2

RUN apk update
RUN apk add openrc
RUN apk add openssl
#RUN apk add vsftpd
RUN apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache
RUN mkdir -p /run/openrc && \
    touch /run/openrc/softlevel && \
    openrc >/dev/null 2>&1

RUN apk add telegraf
RUN mkdir -p etc/telegraf/ && mkdir -p /var/log/telegraf-log
RUN touch /var/log/telegraf-log/telegraf.log
COPY ./srcs/telegraf.conf /etc/telegraf/

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75017/L=Paris/O=42/CN=localhost' -keyout /etc/ssl/private/key.pem -out /etc/ssl/certs/cert.pem >/dev/null 2>&1

RUN { echo "thsembel"; echo "thsembel"; } | adduser user
#COPY ./srcs/vsftpd.conf /etc/vsftpd
COPY ./srcs/start.sh /tmp/start.sh
EXPOSE 21
EXPOSE 42
ENTRYPOINT sh /tmp/start.sh
