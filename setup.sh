RED='\e[1;31m'
GREEN='\e[1;32m'
ORANGE='\e[1;33m'
BLUE='\e[1;34m'
MAGENTA='\e[1;35m'
CYAN='\e[1;36m'
NC='\e[0m'

#1 -Start host machin

minikube delete
sudo service docker start
sudo service nginx stop
sudo service mariadb stop

#2 -Start the cluster
printf "${CYAN}Starting minikube...\n${NC}"
minikube start --vm-driver=docker
printf "${GREEN}[ok]\n\n${NC}"

#3 -Install metallb
printf "${CYAN}Installing metalLB...	${NC}"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml > /dev/null 2>&1 ;\
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml > /dev/null 2>&1 ;\
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null 2>&1
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
docker build --rm -t my-nginx ./srcs/nginx/. > /dev/null 2>&1
printf "${GREEN}[ok]\n${NC}"
printf "${CYAN}Building wordpress image...	${NC}"
docker build --rm -t wordpress ./srcs/wordpress/. > /dev/null 2>&1
printf "${GREEN}[ok]\n${NC}"
printf "${CYAN}Building phpmyadmin image...	${NC}"
docker build --rm -t phpmyadmin ./srcs/PhpMyAdmin/. > /dev/null 2>&1
printf "${GREEN}[ok]\n${NC}"
printf "${GREEN}\nGREAT SUCCESS !\n${NC}"

#5 -Pods Deployment
printf "${CYAN}Deploying pods\n${NC}"
kubectl apply -f ./srcs/MetalLB/metallb.yalm
kubectl apply -f ./srcs/influxDB/influxdb.yalm
kubectl apply -f ./srcs/mysql/mysql.yalm
kubectl apply -f ./srcs/wordpress/wordpress.yalm
kubectl apply -f ./srcs/PhpMyAdmin/phpmyadmin.yalm
kubectl apply -f ./srcs/nginx/nginx.yalm
printf "${GREEN}\nGREAT SUCCESS !\n"

#6 -Open the Dashboard
printf "${CYAN}Opening the Dashboard in Firefox...\n${NC}"
minikube addons enable metrics-server
minikube dashboard
printf "${GREEN}Everything has been created well.\nScript done !${NC}"
