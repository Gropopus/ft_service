FROM alpine:3.13.2

RUN apk update
RUN apk add mysql mysql-client
RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel && openrc >/dev/null 2>&1

COPY ./srcs/conf.sql /tmp/
COPY ./srcs/start.sh /tmp/

EXPOSE 	3306
ENTRYPOINT sh ./tmp/start.sh
