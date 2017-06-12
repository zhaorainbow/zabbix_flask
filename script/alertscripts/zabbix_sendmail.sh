#!/bin/sh
export LANG=zh_CN.UTF-8
echo "time:$(date +%Y-%m-%d-%H:%M:%S)" >> /tmp/email.log
echo "  p3_$3" >> /tmp/email.log
echo "  p2_$2" >> /tmp/email.log
echo "  p1_$1" >> /tmp/email.log
# echo "zabbix test mail" |mail -s "zabbix" yyy@163.com
echo "$3" > /tmp/zabbix_mail
dos2unix /tmp/zabbix_mail
/bin/mail -s "$2" $1 < /tmp/zabbix_mail
echo "  send end ...">>/tmp/email.log
echo "  ">>/tmp/email.log
