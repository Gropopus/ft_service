CREATE DATABASE wordpress;
CREATE USER 'thsembel'@'%' IDENTIFIED BY 'thsembel';
GRANT ALL PRIVILEGES ON wordpress.* TO 'thsembel'@'%';
CREATE USER 'phpthsembel'@'%' IDENTIFIED BY 'thsembel';
GRANT ALL PRIVILEGES ON wordpress.* TO 'thsembel'@'%';
FLUSH PRIVILEGES;
