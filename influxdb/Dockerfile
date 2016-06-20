FROM debian:jessie
EXPOSE 8086 8083 8088

ENV INSTALL_PATH /app

RUN mkdir $INSTALL_PATH
WORKDIR $INSTALL_PATH/

#COPY influxd $INSTALL_PATH

ENV PATH=$INSTALL_PATH:$PATH
RUN apt-get -y update 
RUN apt-get -y install curl wget 

WORKDIR /tmp/
RUN wget https://dl.influxdata.com/influxdb/releases/influxdb-0.13.0_linux_amd64.tar.gz 
RUN tar xvfz influxdb-0.13.0_linux_amd64.tar.gz 
RUN cp /tmp/influxdb-0.13.0-1/usr/bin/influxd /app/
RUN rm -rf /tmp/influx*


RUN influxd config > /etc/influxdb.toml
RUN sed -i 's/dir = "\/.*influxdb/dir = "\/data/' /etc/influxdb.toml

VOLUME ["/data"]

COPY docker-entrypoint.sh $INSTALL_PATH/
ENTRYPOINT ["docker-entrypoint.sh"]
