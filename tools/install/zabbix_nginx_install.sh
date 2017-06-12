#!/bin/bash
echo "请保证该主机无nginx服务，否则ctrl + C退出"
sleep 5
[[ ! -d "/data/app" ]] && mkdir /data/app -p
sum=`/bin/ls -l /data/app/ |wc -l`
NGINX_STATUS=`ps -ef | grep nginx | grep "master process /data/app/nginx/sbin/nginx " |wc -l`
if [[ $sum -eq 1 ]] ;then
	mkdir -p "/data/app"
else
	echo "请保持/data/app/目录为空"
	exit 
fi
id zabbix
[[ $? -eq 1 ]] && useradd zabbix
cd /data/app
wget http://source.zhaolibin.com/zabbix/zabbix_nginx.tar.gz
tar -zxf zabbix_nginx.tar.gz
rm /data/app/zabbix_nginx.tar.gz
wget http://source.zhaolibin.com/zabbix/zabbix_lib.tar.gz
tar -zxf zabbix_lib.tar.gz
rm /data/app/zabbix_lib.tar.gz
\cp /data/app/lib/* /lib64/
rm -rf /data/app/lib
pkill nginx
/data/app/nginx/sbin/nginx
ps -ef | grep nginx
