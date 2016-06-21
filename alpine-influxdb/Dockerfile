FROM alpine

ENV INFLUX_VERSION v0.13.0


RUN set -ex \ 
&& apk add --update --no-cache --virtual .build-deps bash  \
	curl \
	ca-certificates \
	gcc \
	musl-dev \
	openssl \
	make \
	git \
	go \
&& rm -rf /var/cache/apk/* \
&& export GOPATH=/go \
&& export GOROOT=/usr/lib/go \
&& export PATH=$GOPATH/bin:$GOROOT/bin:$PATH \
\
&& go get github.com/sparrc/gdm \ 
&& go get github.com/influxdata/influxdb \
&& go get github.com/influxdata/telegraf \

\
&& cd $GOPATH/src/github.com/influxdata/influxdb \
&& git checkout -q --detach "$INFLUX_VERSION" \
&& gdm restore \
&& LDFLAGS="-X main.version=$INFLUX_VERSION" \
&& LDFLAGS="$LDFLAGS -X main.branch=master" \
&& LDFLAGS="$LDFLAGS -X main.commit=$(git rev-parse --short HEAD)" \
&& LDFLAGS="$LDFLAGS -X main.buildTime=$(date -Iseconds)" \
&& go clean ./... \
&& go install -ldflags="$LDFLAGS" ./... \
&& cp $GOPATH/bin/influx* /usr/bin/ \
\
&& cd $GOPATH/src/github.com/influxdata/telegraf \
&& make \
&& cp $GOPATH/bin/telegraf* /usr/bin/ \
&& mkdir /etc/telegraf/ \
\
&& apk del .build-deps \
&& rm -rf /var/cache/apk/* /tmp/* /var/tmp/* $GOROOT $GOPATH


COPY telegraf.conf /etc/telegraf/

RUN apk add --update curl bash

EXPOSE 8086 8083 8088

RUN influxd config > /etc/influxdb.toml
RUN sed -i 's/dir = "\/.*influxdb/dir = "\/data/' /etc/influxdb.toml

VOLUME ["/data"]

COPY docker-entrypoint.sh /usr/bin/
ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
