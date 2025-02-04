telegraf & ./etc/init.d/mariadb setup
rc-service mariadb start 2> /dev/null
printf "\n n\n n\n y\n y\n y\n y\n" | mysql_secure_installation
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
rc-service mariadb restart
mysql < /tmp/conf.sql
mysql wordpress < /tmp/wordpress.sql
while true;
	do sleep 10000;
done
