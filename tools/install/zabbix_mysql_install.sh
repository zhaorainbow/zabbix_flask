#!/bin/bash
echo "请保证该主机无mysql服务，否则ctrl + C退出"
sleep 5
id mysql
[[ $? -eq 1 ]] && useradd mysql
cd /data/app
wget http://source.zhaolibin.com/zabbix/zabbix_mysql.tar.gz
tar -zxf zabbix_mysql.tar.gz
rm /data/app/zabbix_mysql.tar.gz
chown -R mysql:mysql /data/app/mysql
for i in `ps -ef | grep mysqld | grep -v grep  | awk '{print $2}'`;do kill -s 9 $i;done
/bin/sh /data/app/mysql/bin/mysqld_safe --defaults-file=/data/app/mysql/my.cnf --datadir=/data/app/mysql/data --user=mysql &
