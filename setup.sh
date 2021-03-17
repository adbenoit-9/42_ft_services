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
# min = 5
# sec = 15

# time_progress()
# {
#     if [ sec -eq 0]
#     then
#         if [min -ne 0]
#             --min
#             sec=60
#         fi
#     else
#         --sec
#     fi
# }
progress_anim()
{
    echo -n "     "
    while :;
    do
        echo -n "\b\b\b\b\b[   ]"
        sleep 0.5
        echo -n "\b\b\b\b\b[.  ]"
        sleep 0.5
        # time_progress
        echo -n "\b\b\b\b\b[.. ]"
        sleep 0.5
        echo -n "\b\b\b\b\b[...]"
        sleep 0.5
        # time_progress
    done
}

start_service()
{
    eval $(minikube docker-env)
    echo -n "\033[36;1m$1 \033[0;1m"
    progress_anim & pro_pid=$!
    echo -n "\033[0m"
    docker build -t $1_im srcs/$1 > /dev/null 2> error.log
    if [ $? -eq 0 ]
    then
        kubectl apply -f srcs/$1/$1.yaml > /dev/null 2> error.log
        status=$?
        kill $pro_pid
        wait $pro_pid
    else
        kill $pro_pid
        wait $pro_pid
        echo "\r\033[36;1m$1 image \033[0;1m[\033[31;1m x \033[0;1m]\033[0m"
        exit 1
    fi
    if [ $status -eq 0 ]
    then
        echo "\r\033[36;1m$1 \033[0;1m[\033[32;1m ✔ \033[0;1m]\033[0m"
    else
        echo "\r\033[36;1m$1 deployment\033[0;1m[\033[31;1m x \033[0;1m]\033[0m"
    fi
    eval $(minikube docker-env -u)
}

start_all()
{
    kubectl apply -f srcs/metallb/metallb-configmap.yaml > /dev/null 2> error.log
    echo '\033[34;1mLoad Balancer \033[0;1m[\033[32m ✔ \033[0;1m]\033[0m\n'
    start_service telegraf
    start_service influxdb
    start_service nginx
    start_service mysql
    start_service phpmyadmin
    start_service wordpress
    start_service ftps
    start_service grafana
}

start_project()
{
    # sudo usermod -aG docker user42; newgrp docker
    echo -n "⏰ \033[1;33mminikube: \033[1;39mstarting "
    progress_anim & pro_pid=$!
    minikube start --vm-driver=docker > /dev/null 2> error.log
    status=$?
    kill $pro_pid
    wait $pro_pid
    if [ $status -ne 0 ]
    then
        echo '\r\033[0m💀 \033[1;33mminikube: \033[1;39mstarted [\033[1;31mKO\033[1;39m]\033[0m  \n'
        echo '😭 \033[1;31mFt_services die\033[0m 😭'
        exit 1
    fi
    echo '\r\033[0m🌟 \033[1;33mminikube: \033[1;39mstarted [\033[1;32mOK\033[1;39m]\033[0m  \n'
    minikube addons enable dashboard > /dev/null 2> error.log
    minikube addons enable metrics-server > /dev/null 2> error.log
    minikube addons enable metallb > /dev/null 2> error.log
    kubectl apply -f srcs/metallb/metallb.yaml > /dev/null 2> error.log
    start_all
    echo "______________________________________"
    echo "|              |          |          |"
    echo "|              | username | password |"
    echo "|______________|__________|__________|"
    echo "|  phpmyadmin  |  user42  |  user42  |"
    echo "|______________|__________|__________|"
    echo "|   grafana    |  admin   | password |"
    echo "|______________|__________|__________|\n"
    echo '\n🔥 \033[1;32mft_services is running\033[0m 🔥'
}

clean_service()
{
    eval $(minikube docker-env)
    docker image rm -f $1_im > /dev/null 2> /dev/null
    kubectl delete -f srcs/$1/$1.yaml > /dev/null 2> /dev/null
    echo "\033[36;1m$1 \033[0;1mdeleted\033[0m"
    eval $(minikube docker-env -u)
}

clean_project()
{
    minikube delete > /dev/null 2> /dev/null
    # docker container stop $(docker container ls -aq) > /dev/null
    # docker container rm $(docker container ls -aq) > /dev/null
    docker rmi -f $(docker image ls -a -q) > /dev/null 2> /dev/null
    echo "🗑️  \033[33;1mminikube \033[0;1mdeleted\033[0m"
}

clean_all()
{
    kubectl delete -f srcs/metallb/metallb-configmap.yaml > /dev/null 2> error.log
    echo "\033[36;1mLoad Balancer \033[0;1mdeleted\033[0m"
    clean_service nginx
    clean_service mysql
    clean_service phpmyadmin
    clean_service wordpress
    clean_service ftps
    clean_service influxdb
    clean_service telegraf
    clean_service grafana
}

restart_it()
{
    # eval $(minikube docker-env)
    if [ $1 = "minikube" ]
        then
        clean_project
        start_project
    elif [ $1 = "all" ]
        then
        clean_all
        start_all
    elif [ $1 != "" ]
        then
        clean_service $1
        start_service $1
    else
        echo "⚠️ restart: $1: no such service"
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
    elif [ $1 != "" ]
        then
        clean_service $1
    else
        echo "⚠️ clean: $1: no such service"
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
        echo "⚠️ tart: $1: no such service"
    else
        start_service $1
    fi
}

restart_pods()
{
    kubectl get pod
    echo -n "\n\033[33;1mpods: \033[0;1mdeleting \033[0m"
    progress_anim & pro_pid=$!
    kubectl delete --all pod > /dev/null
    kill $pro_pid
    wait $pro_pid
    echo "\r🗑️  \033[33;1mpods: \033[0;1mdeleted            \033[0m\n"
    echo '\033[0m🌟 \033[1;33mpods: \033[1;39mrestarted [\033[1;32mOK\033[1;39m]\033[0m\n'
    kubectl get pod
}

echo "\033[34m"
cat ft_services.txt
echo "\033[0m"

if [ $1 = "restart" ]
    then
    echo "\033[1;33m$2 restarting ... \033[0m"
    if [ $2 = "pods" ]
    then
        restart_pods
    else
        restart_it $2
    fi
elif [ $1 = "clean" ]
    then
    echo "\033[1;33m$2 cleaning ... \033[0m"
    clean_it $2
elif [ $1 = "start" ]
    then
    echo "\033[1;33m$2 starting ... \033[0m"
    start_it $2
else
    echo "$0: illegal option -- $1"
    echo "usage: $0"
    echo "      - clean [arg]"
    echo "      - start [arg]"
    echo "      - restart [arg]"
    echo ""
    echo "arg:"
    echo "      - minikube      (apply to all the project)"
    echo "      - service name  (apply to the service)"
    echo "      - all           (apply to all services without restart minikube)\n"
    echo "      - pods          (can only be apply to restart)"
fi
