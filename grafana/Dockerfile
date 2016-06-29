FROM debian:jessie

ENV BUILD_PACKAGES libfontconfig wget git 


RUN apt-get -y update
RUN apt-get -y install $BUILD_PACKAGES curl

WORKDIR /tmp
RUN wget -O /tmp/grafana.tgz https://grafanarel.s3.amazonaws.com/builds/grafana-3.0.4-1464167696.linux-x64.tar.gz \
&& wget -O /tmp/telegraf.tgz https://dl.influxdata.com/telegraf/releases/telegraf-1.0.0-beta1_linux_amd64.tar.gz \
&& mkdir -p /opt/grafana \
&& tar -zxvf /tmp/grafana.tgz  \
&& mv -f /tmp/grafana-3.0.4-1464167696/* /opt/grafana/. \
&& tar -zxvf /tmp/telegraf.tgz \
&& mkdir -p /opt/telegraf \
&& mv -f /tmp/telegraf/* /opt/telegraf/. \
&& rm -rf /tmp/grafana* \
&& rm -rf /tmp/telegraf

RUN mkdir -p /opt/grafana/data/plugins \ 
&& cd /opt/grafana/data/plugins/ \
&& git clone https://github.com/grafana/piechart-panel.git

RUN apt-get remove --purge -y wget libfontconfig git && apt-get clean &&rm -rf /var/lib/apt/lists/*

COPY telegraf.conf /opt/telegraf/etc/telegraf/
COPY grafana_dash.json /opt/grafana/

EXPOSE 3000

VOLUME ["/opt/grafana/data"]
VOLUME ["/opt/grafana/conf"]

WORKDIR /opt/grafana/

COPY ./docker-entrypoint.sh /opt/grafana/
ENTRYPOINT ["./docker-entrypoint.sh"]
