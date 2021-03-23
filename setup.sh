RED='\e[1;31m'
GREEN='\e[1;32m'
ORANGE='\e[1;33m'
BLUE='\e[1;34m'
MAGENTA='\e[1;35m'
CYAN='\e[1;36m'
NC='\e[0m'

printf "${BLUE}"
printf "#*********************************************************************************#\n"
printf "#                                        |                                        #\n"
printf "#                                       .-.                                       #\n"
printf "#                                      /___\                                      #\n"
printf "#                                      |___|                                      #\n"
printf "#                                      |]_[|                                      #\n"
printf "#                                      / I \                                      #\n"
printf "#                                   JL/  |  \JL                                   #\n"
printf "#        .-.                    i   ()   |   ()   i                    .-.        #\n"
printf "#        |_|     .^.           /_\  LJ=======LJ  /_\           .^.     |_|        #\n"
printf "#  _._._/___\._./___\_._._._._.L_J_/.-. .-. .-.\_L_J._._._._._/___\._./___\._._.  #\n"
printf "#  .,        ., |-,-| .,       L_J  |_| [I] |_|  L_J       ., |-,-| .,        .,  #\n"
printf "#  JL        JL |-O-| JL       L_J***************L_J       JL |-O-| JL        JL  #\n"
printf "#  HH_IIIIII_HH_'-'-'_HH_IIIIII|_|=======H=======|_|IIIIII_HH_'-'-'_HH_IIIIII_HH  #\n"
printf "#  []--------[]-------[]-------[_]----\.=I=./----[_]-------[]-------[]--------[]  #\n"
printf "#  ||  _/\_  ||\ _I_ /||  _/\_ [_] []_/_L_J_\_[] [_] _/\_  ||\ _I_ /||  _/\_  ||  #\n"
printf "#  ||  |__|  ||=/_|_\=||  |__|_|_|   _L_L_J_J_   |_|_|__|  ||=/_|_\=||  |__|  ||  #\n"
printf "#  ||  |__|  |||__|__|||  |__[___]__--__===__--__[___]__|  |||__|__|||  |__|  ||  #\n"
printf "#  [_]IIIIIII[_]IIIII[_]IIIIIL___J__II__|_|__II__L___JIIIII[_]IIIII[_]IIIIIII[_]  #\n"
printf "#  [_] \_I_/ [_]\_I_/[_] \_I_[_]\II/[]\_\I/_/[]\II/[_]_I_/ [_]\_I_/[_]\_I_/  [_]  #\n"
printf "#  L_J./   \.L_J/   \L_J./   L_JI  I[]/     \[]I  IL_J   \.L_J/   \L_J./   \.L_J  #\n"
printf "#  L_J|     |L_J|   |L_J|    L_J|  |[]|     |[]|  |L_J    |L_J|   |L_J|     |L_J  #\n"
printf "#  L_JL_____JL_JL___JL_JL____|-||  |[]|     |[]|  ||-|____JL_JL___JL_JL_____JL_J  #\n"
printf "#                                   FT_SERVICES                                   #\n"
printf "#*********************************************************************************#\n"
printf "${NC}"

#1 -Start host machin
printf "${CYAN}Preparing host machine...\n${NC}"
minikube delete
sudo service docker start
sudo service nginx stop
sudo service mariadb stop
sudo service influxdb stop

#2 -Start the cluster
printf "${CYAN}Starting minikube...\n${NC}"
minikube start --vm-driver=docker
printf "${CYAN}Cluster started${NC}${GREEN}			[ok]\n${NC}"

#3 -Install metallb and filezilla
printf "${CYAN}Installing metalLB...		${NC}"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml > /dev/null 2>&1 ;\
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml > /dev/null 2>&1 ;\
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null 2>&1
printf "${GREEN}[ok]\n${NC}"
printf "${CYAN}Installing filezilla		${NC}"
sudo apt-get install filezilla > /dev/null 2>&1
printf "${GREEN}[ok]\n${NC}"


#4 -Build Docker images
printf "${BLUE}\nBuilding Docker images\n${NC}"
printf "${ORANGE}WARNING: This is going to take a while...\n\n${NC}"
eval $(minikube docker-env)
printf "${CYAN}Buildind influxDB image...	${NC}"
docker build --rm -t influxdb ./srcs/influxDB/. > /dev/null 2>&1
printf "${GREEN}[ok]\n${NC}"
printf "${CYAN}Building mysql image...		${NC}"
docker build --rm -t mysql ./srcs/mysql/. > /dev/null 2>&1
printf "${GREEN}[ok]\n${NC}"
printf "${CYAN}Building ngynx image...		${NC}"
docker build --rm -t nginx ./srcs/nginx/. > /dev/null 2>&1
printf "${GREEN}[ok]\n${NC}"
printf "${CYAN}Building wordpress image...	${NC}"
docker build --rm -t wordpress ./srcs/wordpress/. > /dev/null 2>&1
printf "${GREEN}[ok]\n${NC}"
printf "${CYAN}Building phpmyadmin image...	${NC}"
docker build --rm -t phpmyadmin ./srcs/PhpMyAdmin/. > /dev/null 2>&1
printf "${GREEN}[ok]\n${NC}"
printf "${CYAN}Building grafana images...	${NC}"
docker build --rm -t grafana ./srcs/Grafana/. > /dev/null 2>&1
printf "${GREEN}[ok]\n${NC}"
printf "${CYAN}Building ftps images...		${NC}"
docker build -t ftps ./srcs/Ftps/. #> /dev/null 2>&1
printf "${GREEN}[ok]\n${NC}"
printf "${GREEN}\nGREAT SUCCESS !\n${NC}"

#5 -Pods Deployment
printf "${CYAN}Deploying pods\n${NC}"
printf "${GREEN}"
kubectl apply -f ./srcs/MetalLB/metallb.yaml
kubectl apply -f ./srcs/influxDB/influxdb-pv.yaml
kubectl apply -f ./srcs/influxDB/influxdb.yaml
kubectl apply -f ./srcs/mysql/mysql-pv.yaml
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml
kubectl apply -f ./srcs/PhpMyAdmin/phpmyadmin.yaml
kubectl apply -f ./srcs/nginx/nginx.yaml
kubectl apply -f ./srcs/Grafana/grafana.yaml
kubectl apply -f ./srcs/Ftps/ftps.yaml
kubectl apply -f ./srcs/Telegraf/telegraf.yaml
printf "${NC}${GREEN}\nGREAT SUCCESS !\n\n${NC}"

#6 -Open the Dashboard
printf "${CYAN}Displaying Pods and Services status...\n${NC}"
minikube addons enable metrics-server
kubectl get all
printf "${CYAN}Opening the Dashboard in Firefox...\n${NC}"
minikube dashboard
