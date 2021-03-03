FROM alpine:3.13.2

RUN apk update
RUN apk add wget
RUN apk add php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session php-sockets php7-common php7-opcache php7-zlib php7-curl php7-gd php7-cgi
RUN apk add nginx
RUN apk add openssl


#COPY ./srcs/default.conf /etc/nginx/conf.d/
COPY ./srcs/nginx.conf /etc/nginx/
RUN mkdir -p /run/nginx
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75017/L=Paris/O=42/CN=thsembel' -keyout /etc/nginx/localhost.key -out /etc/nginx/localhost.crt

WORKDIR /var/www/localhost/
COPY ./srcs/phpmyadmin /var/www/localhost/
COPY ./srcs/config.inc.php /var/www/localhost/phpmyadmin/
RUN chmod -R 777 /var/www/localhost/phpmyadmin/

ENTRYPOINT service php-fpm7 start >/dev/null
ENTRYPOINT nginx -g "daemon off;"
EXPOSE 5000
