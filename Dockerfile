FROM nginx

MAINTAINER Alexey Kupershtokh <alexey.kupershtokh@gmail.com>

ADD https://download.elastic.co/kibana/kibana/kibana-3.1.2.tar.gz /tmp/

RUN tar -C /usr/share/nginx/html --strip-components=1 -xf /tmp/kibana-3.1.2.tar.gz
