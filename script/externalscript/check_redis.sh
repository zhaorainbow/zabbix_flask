#!/bin/sh
###Version 1 Create by PQL on 20160727
###Version 2 modified by WYY ON 20161010 (used_memory -- percent)

PORT=$1
key=$2
apppath="/usr/local/zabbix/bin/redis-cli"
IPADDR=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
#sudo $apppath -h 10.252.22.135 -p $PORT INFO |grep "$key:"|sed s/'\r'/''/g |awk -F: '{print $2}'

output=$(sudo $apppath -h $IPADDR -p $PORT INFO |grep "$key:"|sed s/'\r'/''/g |awk -F: '{print $2}')

if [ "$2"x = "used_memory"x ]; then
  name=`ls -al /usr/local/ |grep redis |head -1 |awk '{print $9}'`
  sys_mem=$(sudo cat "/usr/local/$name/redis.conf" |grep '^maxmemory ' |awk '{print $2}')
  echo "scale=2; $output * 100 / $sys_mem" |bc
else
  echo $output
fi
