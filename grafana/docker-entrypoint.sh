#!/bin/bash

/opt/telegraf/usr/bin/telegraf --config /opt/telegraf/etc/telegraf/telegraf.conf &
/opt/grafana/bin/grafana-server web &

sleep 5

curl 'http://admin:admin@localhost:3000/api/datasources' -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"name":"influx","type":"influxdb","url":"http://influxdb:8086","access":"proxy","isDefault":true,"database":"telegraf","user":"admin","password":"admin"}' > /dev/null
curl -X POST -i 'http://admin:admin@localhost:3000/api/dashboards/db' --data-binary '@/opt/grafana/grafana_dash.json' -H "Content-Type: application/json" -H "Accept: application/json"

wait
