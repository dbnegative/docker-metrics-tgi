#!/bin/bash

$INSTALL_PATH/influxd --config /etc/influxdb.toml & 

sleep 10 

curl -POST 'http://localhost:8086/query?u=admin&p=admin' --data-urlencode 'q=CREATE DATABASE mydb'

wait
