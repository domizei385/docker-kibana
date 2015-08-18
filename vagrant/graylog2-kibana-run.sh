#!/bin/sh
cd ~
ES_ID=$(docker run -d -p 9200:9200 -p 9300:9300 elasticsearch:latest)
ES_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${ES_ID})

git clone https://github.com/domizei385/docker-kibana.git --branch 'kibana-4.1'
cd docker-kibana
docker build -t kibana .
cd ..
KI_ID=$(docker run -d -p 8080:5601 -e "ES_HOST=${ES_IP}" -e "ES_PORT=9200" kibana)

docker run -t -p 9000:9000 -p 12201:12201 graylog2/allinone