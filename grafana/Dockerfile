FROM debian:jessie

RUN apt-get -y update
RUN apt-get -y install libfontconfig curl wget

WORKDIR /tmp
RUN wget -O /tmp/grafana.tgz https://grafanarel.s3.amazonaws.com/builds/grafana-3.0.4-1464167696.linux-x64.tar.gz \
&& mkdir -p /opt/grafana \
&& tar -zxvf /tmp/grafana.tgz  \
&& mv -f /tmp/grafana-3.0.4-1464167696/* /opt/grafana/. \
&& rm -rf /tmp/grafana*

EXPOSE 3000

VOLUME ["/opt/grafana/data"]
VOLUME ["/opt/grafana/conf"]

WORKDIR /opt/grafana/

COPY ./docker-entrypoint.sh /opt/grafana/
ENTRYPOINT ["./docker-entrypoint.sh"]
