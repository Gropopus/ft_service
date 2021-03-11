FROM alpine:3.13.2

RUN apk update
RUN apk add 
RUN apk add grafana

RUN apk add --no-cache openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75017/L=Paris/O=42/CN=localhost' -keyout /etc/ssl/private/key.pem -out /etc/ssl/certs/cert.pem >/dev/null 2>&1

RUN rm -rf /share/grafana/conf/sample.ini
COPY ./srcs/sample.ini /usr/share/grafana/conf/
COPY ./srcs/start.sh /tmp/

EXPOSE 3000
ENTRYPOINT sh ./tmp/start.sh
