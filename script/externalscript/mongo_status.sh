#!/bin/bash
##mongo_status.sh##
##wuhf##
mongo='/usr/local/zabbix/bin/mongo'
case $# in
 3)
  output=$(/bin/echo "db.serverStatus().$3" | $mongo $1:$2/admin -umonitor -pMongo.Syswin --quiet)
  ;;
 4)
  output=$(/bin/echo "db.serverStatus().$3.$4" | $mongo $1:$2/admin  -umonitor -pMongo.Syswin --quiet)
  ;;
 5)
  output=$(/bin/echo "db.serverStatus().$3.$4.$5" | $mongo $1:$2/admin  -umonitor -pMongo.Syswin --quiet)
  ;;
esac
if [[ "$output" =~ "NumberLong"  ]];then
 echo $output|sed -n 's/NumberLong(//p'|sed -n 's/)//p'
else
 if [ "$3"x = "mem"x ] && [ "$4"x = "resident"x ]; then
    sys_mem=$(free -m |grep Mem |awk '{print $2}')
    # mem_percent=$[$output * 100 / $sys_mem]
    echo "scale=2; $output * 100 / $sys_mem" |bc
    #echo $mem_percent
 else
   echo $output
 fi
fi
