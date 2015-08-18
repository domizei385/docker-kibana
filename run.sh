#!/bin/bash
ES_HOST=${ES_HOST:-\"+window.location.hostname+\"}
ES_PORT=${ES_PORT:-9200}
ES_SCHEME=${ES_SCHEME:-http}

# disable ipv6 support
if [ ! -f /proc/net/if_inet6 ]; then
  sed -e '/listen \[::\]:80/ s/^#*/#/' -i /etc/nginx/sites-enabled/*
fi

cp /opt/kibana/config/kibana.yml /opt/kibana/config/old.yml
cat /opt/kibana/config/kibana.yml
sed -e "s/localhost:9200/${ES_HOST}:${ES_PORT}/" /opt/kibana/config/old.yml > /opt/kibana/config/kibana.yml

nginx -c /etc/nginx/nginx.conf -g 'daemon off;'

service kibana4 start
