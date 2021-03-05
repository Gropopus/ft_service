CREATE DATABASE wordpress;

CREATE USER 'thsembel' IDENTIFIED BY 'thsembel';
GRANT USAGE ON wordpress.* TO 'thsembel'@'localhost' IDENTIFIED BY 'thsembel';
GRANT ALL PRIVILEGES ON wordpress.* TO 'thsembel'@'localhost';
FLUSH PRIVILEGES;

