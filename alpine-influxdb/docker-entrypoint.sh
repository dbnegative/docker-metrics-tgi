#!/bin/bash

/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &
influxd --config /etc/influxdb.toml & 

sleep 10 

curl -POST 'http://localhost:8086/query?u=admin&p=admin' --data-urlencode 'q=CREATE DATABASE mydb'

wait
