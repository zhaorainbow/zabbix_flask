#!/bin/sh
export LANG=zh_CN.UTF-8
echo "time:$(date +%Y-%m-%d-%H:%M:%S)" >> /tmp/weixin.log
echo "  p3_$3" >> /tmp/weixin.log
echo "  p2_$2" >> /tmp/weixin.log
echo "  p1_$1" >> /tmp/weixin.log
# echo "zabbix test mail" |mail -s "zabbix" yyy@163.com
echo "$3" > /tmp/zabbix_weixin
dos2unix /tmp/zabbix_weixin
ip=`cat /tmp/zabbix_weixin | grep "服务器IP" | awk '{print $2}'`
key=`cat /tmp/zabbix_weixin | grep "告警项目" | awk '{print $2}'`
content=`cat /tmp/zabbix_weixin`
/usr/bin/python /usr/local/zabbix/share/zabbix/alertscripts/zabbix_weixin.py $ip $key "$content"
echo "  send end ...">>/tmp/weixin.log
echo "  ">>/tmp/weixin.log
