#!/bin/bash
echo "请保证该主机无php服务，否则ctrl + C退出"
sleep 5
id zabbix
[[ $? -eq 1 ]] && useradd zabbix
cd /data/app
wget http://source.zhaolibin.com/zabbix/zabbix_php.tar.gz
tar -zxf zabbix_php.tar.gz
rm /data/app/zabbix_php.tar.gz
wget http://source.zhaolibin.com/zabbix/zabbix_lib.tar.gz
tar -zxf zabbix_lib.tar.gz
rm /data/app/zabbix_lib.tar.gz
\cp /data/app/lib/* /lib64/
rm -rf /data/app/lib
pkill php-fpm
/data/app/php/sbin/php-fpm -c /data/app/php/lib/php.ini
ps -ef | grep php
