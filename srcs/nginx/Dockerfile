FROM alpine:3.13.2
# On telecharge les paquets sur le server alpine
RUN apk update && apk add nginx
RUN apk add openssh
RUN apk add openssl

RUN apk add telegraf
RUN mkdir -p etc/telegraf/ && mkdir -p /var/log/telegraf-log
RUN touch /var/log/telegraf-log/telegraf.log
COPY ./srcs/telegraf.conf /etc/telegraf/

RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
RUN mkdir -p /run/nginx

COPY ./srcs/launch.sh /var/
COPY ./srcs/nginx.conf /etc/nginx/
COPY ./srcs/index.html /www/index.html
COPY ./srcs/test.txt etc/www/

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75017/L=Paris/O=42/CN=thsembel' -keyout /etc/nginx/localhost.key -out /etc/nginx/localhost.crt
RUN chmod 777 ./var/launch.sh

EXPOSE 80
EXPOSE 443
ENTRYPOINT sh /var/launch.sh
