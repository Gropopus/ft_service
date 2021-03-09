minikube delete

#Start host machin

sudo service docker start
sudo service nginx stop
sudo service mariadb stop
#start your cluster

minikube start --vm-driver=docker
eval $(minikube docker-env)
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

#build les Docker images
docker build --rm -t wordpress ./srcs/wordpress/.
docker build --rm -t phpmyadmin ./srcs/PhpMyAdmin/.
docker build --rm -t my-mysql ./srcs/mysql/.
docker build --rm -t my-nginx ./srcs/nginx/.

kubectl apply -f ./srcs/MetalLB/metallb.yalm
kubectl apply -f ./srcs/mysql/mysql.yalm
kubectl apply -f ./srcs/wordpress/wordpress.yalm
kubectl apply -f ./srcs/PhpMyAdmin/phpmyadmin.yalm
kubectl apply -f ./srcs/nginx/nginx.yalm
