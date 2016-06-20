# Docker + Telegraf + Grafana + Influxdb 

Grafana and Influxdb in Docker containers built with Debian Jessie. A new datasource/db have been created and linked. Edit docker-entrypoint.sh wrapper scripts to change variables. 

```
docker-compose up -d 
```

### TODO
* Add Telegraf to both containers and build test container.
* use alpine - requires a complete go build process for influxdb/grafana.
* better ENV vars
* more options 
