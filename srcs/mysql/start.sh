#!/bin/bash

mysql_install_db --user=root --datadir=/var/lib/mysql
mysqld --init_file=/config.sql

while true
do
	sleep 1;
done