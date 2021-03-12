rc-service influxdb start
echo "CREATE DATABASE metrics-db" | influx
echo "CREATE USER thsembel WITH PASSWORD thsembel WITH ALL PRIVILEGES" | influx
telegraf & sleep infinity
