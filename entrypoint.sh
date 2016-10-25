#!/bin/bash

#Install webmin
cd /home
tar -zxvf webmin.tar.gz
cd webmin-1.820
./setup.sh /usr/local/webmin

#Create report sarg every day 22:00
cd /etc && echo "00 22 * * * /usr/sbin/sarg-reports today" >> crontab

#Add dns to container
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

