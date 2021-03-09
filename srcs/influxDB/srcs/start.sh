rc-service influxdb start
echo "CREATE DATABASE metrics" | influx
echo "CREATE USER 'thsembel' WITH PASSWORD 'thsembel' WITH ALL PRIVILEGES" | influx
sleep infinity
