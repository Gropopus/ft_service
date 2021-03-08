# ft_service
https://kubernetes.io/fr/docs/concepts/services-networking/service/
service nginx stop

service mariadb stop

# clean the cluster

minikube delete

# Start host machin 

service docker start

# start your cluster

minikube start --vm-driver=docker

eval $(minikube docker-env)
