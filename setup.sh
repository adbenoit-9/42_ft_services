#!/bin/bash

# sh init_docker.sh
# sudo usermod -aG docker user42; newgrp docker
# sleep 60
# docker container stop $(docker container ls -aq)
# docker container rm $(docker container ls -aq)
# docker rmi -f $(docker image ls -a -q)

# minikube config set vm-driver virtualbox

# docker-machine create --driver virtualbox default
# docker-machine start
# minikube start --vm-driver=virtualbox

start_service()
{
    docker build -t $1_im srcs/$1
    if [ $? -eq 0 ]
    then
        kubectl apply -f srcs/$1/$1.yaml
    fi
    if [ $? -eq 0 ]
    then
        echo "\033[34m$1 \033[0m[\033[32mOK\033[0m]"
    fi
}

start_project()
{
    # sudo usermod -aG docker user42; newgrp docker
    minikube start --vm-driver=docker
    if [ $? -ne 0 ]
    then
        echo '\033[1;33mminikube: \033[1;39mstarted [\033[1;31mKO\033[1;39m]\033[0m\nexit'
        exit 1
    fi
    echo '\033[1;33mminikube: \033[1;39mstarted [\033[1;32mOK\033[1;39m]\033[0m'
    minikube addons enable dashboard
    minikube addons enable metrics-server
    # minikube addons enable metallb 
    # if [ $? -ne 0 ]
    # then
        kubectl apply -f srcs/metallb/metallb.yaml
    # fi
    kubectl apply -f srcs/metallb/metallb-configmap.yaml
    echo '\033[34mLoad Balancer \033[0m[\033[32mOK\033[0m]'
    eval $(minikube docker-env)
    # sudo service nginx stop
    echo user42
    start_service nginx
    start_service mysql
    # eval $(minikube docker-env -u)
}

clean_service()
{
    docker image rm -f $1_im
    kubectl delete -f srcs/$1/$1.yaml
}

clean_project()
{
    eval $(minikube docker-env -u)
    minikube delete
    docker container stop $(docker container ls -aq)
    docker container rm $(docker container ls -aq)
    docker rmi -f $(docker image ls -a -q)
}

clean_all()
{
    kubectl delete -f srcs/metallb/metallb-configmap.yaml
    clean_service nginx
    clean_service mysql
}

start_all()
{
    kubectl apply -f srcs/metallb/metallb-configmap.yaml
    start_service nginx
    start_service mysql
}

restart_it()
{
    if [ $1 = "minikube" ]
        then
        clean_project
        start_project
    elif [ $1 = "all" ]
        then
        clean_all
        start_all
    elif [ $1 -ne 0 ]
        then
        clean_service $1
        start_service $1
    else
        echo "restart: $1: no such service"
    fi
}

clean_it()
{
    if [ $1 = "all" ]
        then
        clean_all
    elif [ $1 = "minikube" ]
        then
        clean_project
    elif [ $# -ne 1 ]
        then
        clean_service $?
    else
        echo "clean: $1: no such service"
    fi
}

start_it()
{
    if [ $1 = "all" ]
        then
        start_all
    elif [ $1 = "minikube" ]
        then
        start_project
    elif [ -z "$1" ]
        then
        echo "start: $1: no such service"
    else
        start_service $1
    fi
}

if [ $1 = "restart" ]
    then
    echo "\033[1;39m$2 restarting ... \033[0m"
    restart_it $2
elif [ $1 = "clean" ]
    then
    echo "\033[1;39m$2 cleaning ... \033[0m"
    clean_it $2
elif [ $1 = "start" ]
    then
    echo "\033[1;39m$2 starting ... \033[0m"
    start_it $2
else
    echo "$0: illegal option -- $1"
    echo "usage: $0"
    echo "      - clean [arg]"
    echo "      - start [arg]"
    echo "      - restart [arg]"
fi

# cd mysql/
# sh run.sh
# kubectl apply -f mysql.yaml
# cd ../

# cd phpmyadmin/
# sh run.sh
# kubectl apply -f phpmyadmin.yaml
# cd ../

# cd wordpress/
# sh run.sh
# kubectl apply -f wordpress.yaml
# cd ../

# cd ftps/
# sh run.sh
# kubectl apply -f ftps.yaml
# cd ../

# cd grafana/
# sh run.sh
# kubectl apply -f grafana.yaml
# cd ../../

# kubectl apply -f src/dashboard.yaml
# echo '\033[34mDashboard \033[0m[\033[32mOK\033[0m]'
# kubectl proxy
