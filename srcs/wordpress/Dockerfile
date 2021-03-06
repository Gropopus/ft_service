FROM alpine:3.13.2

RUN apk update
RUN apk add nginx
RUN apk add php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session php-sockets php7-common php7-opcache php7-zlib php7-curl php7-gd php7-cgi
RUN apk add openssl

COPY ./srcs/start.sh /tmp/

RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel && openrc >/dev/null 2>&1

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75017/L=Paris/O=42/CN=thsembel' -keyout /etc/nginx/localhost.key -out /etc/nginx/localhost.crt >/dev/null 2>&1

RUN mkdir -p /run/nginx
COPY ./srcs/default.conf /etc/nginx/conf.d/

WORKDIR /var/www/
RUN wget -q http://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz && rm latest.tar.gz
RUN chmod -R 755 wordpress
RUN rm -rf /var/wordpress/wp-config-sample.php
COPY /srcs/wp-config.php /var/www/wordpress/

EXPOSE 5050
ENTRYPOINT sh /tmp/start.sh
