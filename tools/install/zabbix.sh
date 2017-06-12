#!/bin/bash
echo "zabbix will install"
sleep 3
echo "INSTALL nginx"
curl http://source.zhaolibin.com/zabbix/zabbix_nginx_install.sh |sh 
sleep 2
echo  "INSTALL php"
curl http://source.zhaolibin.com/zabbix/zabbix_php_install.sh |sh 
sleep 2
echo "INSTALL mysql"
curl http://source.zhaolibin.com/zabbix/zabbix_mysql_install.sh |sh 
echo "INSTALL zabbix"
curl http://source.zhaolibin.com/zabbix/zabbix_server_install.sh |sh 
