#!/bin/bash

/opt/grafana/bin/grafana-server web & 

sleep 5 

curl 'http://admin:admin@localhost:3000/api/datasources' -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"name":"influx","type":"influxdb","url":"http://influxdb:8086","access":"proxy","isDefault":true,"database":"mydb","user":"admin","password":"admin"}' > /dev/null

wait
