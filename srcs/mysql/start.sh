#!/bin/bash

if [[ ! -d "/var/lib/mysql/mysql" ]]
then
    mysql_install_db --user=root --datadir=/var/lib/mysql
    mysqld --user=root --init_file=/config.sql
fi

# while true
# do
# 	sleep 1;
# done