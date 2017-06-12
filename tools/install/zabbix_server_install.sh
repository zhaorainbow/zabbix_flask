#!/bin/bash
cd /usr/local
rm -rf /usr/local/zabbix
wget http://source.zhaolibin.com/zabbix/zabbix_server.tar.gz
tar -zxf zabbix_server.tar.gz
rm /usr/local/zabbix_server.tar.gz
/usr/local/zabbix/zabbix_server restart
/usr/local/zabbix/zabbix_agentd restart
