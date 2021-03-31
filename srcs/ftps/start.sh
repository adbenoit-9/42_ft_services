#!/bin/bash

USER=user42
PASSWORD=user42
FOLDER="/ftp"

echo -e "$PASSWORD\n$PASSWORD" | adduser -h $FOLDER -s /sbin/nologin -u 1000 $USER

chown $USER:$USER $FOLDER
unset USER PASSWORD FOLDER
exec /usr/sbin/vsftpd -opasv_address="192.168.49.2" /etc/vsftpd/vsftpd.conf
