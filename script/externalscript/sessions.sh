#!/bin/sh
pstree -p `ps -ef |grep $1 |egrep -v "grep|/usr/local/zabbix/bin/"|awk '{print $2}'`|wc -l
