FROM nginx:1.7

ENV KIBANA_VERSION 4.1.1-linux-x64

ADD run.sh /usr/local/bin/run

ADD https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}.tar.gz /tmp/kibana.tar.gz
RUN tar xf /tmp/kibana.tar.gz -C /opt/kibana --strip-components=1

ADD https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/bce61d85643c2dcdfbc2728c55a41dab444dca20/kibana4 /etc/init.d/kibana4
RUN chmod +x /etc/init.d/kibana4
RUN update-rc.d kibana4 defaults 96 9
RUN service kibana4 start

EXPOSE 80

CMD ["/usr/local/bin/run"]
