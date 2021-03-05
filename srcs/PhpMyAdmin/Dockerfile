FROM alpine:3.13.2

RUN apk update
RUN apk add wget
RUN apk add php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session php-sockets php7-common php7-opcache php7-zlib php7-curl php7-gd php7-cgi
RUN apk add nginx
RUN apk add openssl


RUN apk add --no-cache openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN openrc >/dev/null 2>&1

COPY ./srcs/default.conf /etc/nginx/conf.d/
RUN mkdir -p /run/nginx
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75017/L=Paris/O=42/CN=thsembel' -keyout /etc/nginx/localhost.key -out /etc/nginx/localhost.crt >/dev/null 2>&1

WORKDIR /var/www/localhost/ 
RUN wget -q http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz && \
    tar -zxvf phpMyAdmin-5.0.2-all-languages.tar.gz && rm phpMyAdmin-5.0.2-all-languages.tar.gz  && \
    mv phpMyAdmin-5.0.2-all-languages phpmyadmin && \
    chmod -R 777 /var/www/localhost/phpmyadmin/
COPY /srcs/config.inc.php /var/www/localhost/phpmyadmin/

COPY ./srcs/start.sh tmp/start.sh
EXPOSE 5000
ENTRYPOINT sh ./tmp/start.sh
