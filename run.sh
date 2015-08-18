#!/bin/bash
ES_HOST=${ES_HOST:-\"+window.location.hostname+\"}
ES_PORT=${ES_PORT:-9200}
ES_SCHEME=${ES_SCHEME:-http}

# disable ipv6 support
if [ ! -f /proc/net/if_inet6 ]; then
  sed -e '/listen \[::\]:80/ s/^#*/#/' -i /etc/nginx/sites-enabled/*
fi

sed -e "s/localhost:9200/${ES_HOST}:${ES_PORT}/" /usr/share/nginx/html/config/kibana.yml > /usr/share/nginx/html/config/kibana.yml

cat << EOF > /usr/share/nginx/html/config.js
define(['settings'],
function (Settings) {
  return new Settings({
    elasticsearch: "$ES_SCHEME://$ES_HOST:$ES_PORT",
    default_route     : '/dashboard/file/logstash.json',
    kibana_index: "kibana-int",
    panel_names: [
      'histogram',
      'map',
      'goal',
      'table',
      'filtering',
      'timepicker',
      'text',
      'hits',
      'column',
      'trends',
      'bettermap',
      'query',
      'terms',
      'stats',
      'sparklines'
    ]
  });
});
EOF

nginx -c /etc/nginx/nginx.conf -g 'daemon off;'
