#!/bin/sh 
#Create by PQL 2015.9.10
mysqladmin="/usr/local/zabbix/bin/mysqladmin"
mysql="/usr/local/zabbix/bin/mysql"
MYSQLIP='127.0.0.1'
MYSQLPORT=$1
MYSQL_PWD='monitor123' 
ARGS=2
if [ $# -ne "$ARGS" ];then 
    echo "Please input one arguement:" 
fi 
case $2 in
    alive)
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD}  ping 2>/dev/null`
	if [[  "$result" == "mysqld is alive" ]] ;then
		echo "1"
	else
		echo "0"
	fi
        #    echo $result 
            ;; 
    Uptime) 
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} status 2>/dev/null|cut -f2 -d":"|cut -f1 -d"T"` 
            echo $result
            ;; 
        Com_update) 
            result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} extended-status 2>/dev/null |grep -w "Com_update"|cut -d"|" -f3` 
            echo $result 
            ;; 
        Slow_queries) 
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} status 2>/dev/null |cut -f5 -d":"|cut -f1 -d"O"` 
                echo $result 
                ;; 
    Com_select) 
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} extended-status 2>/dev/null |grep -w "Com_select"|cut -d"|" -f3` 
                echo $result 
                ;; 
    Com_rollback) 
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} extended-status 2>/dev/null |grep -w "Com_rollback"|cut -d"|" -f3` 
                echo $result 
                ;; 
    Questions) 
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} status 2>/dev/null |cut -f4 -d":"|cut -f1 -d"S"` 
                echo $result 
                ;; 
    Com_insert) 
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} extended-status 2>/dev/null |grep -w "Com_insert"|cut -d"|" -f3` 
                echo $result 
                ;; 
    Com_delete) 
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} extended-status 2>/dev/null |grep -w "Com_delete"|cut -d"|" -f3` 
                echo $result 
                ;; 
    Com_commit) 
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} extended-status 2>/dev/null |grep -w "Com_commit"|cut -d"|" -f3` 
                echo $result 
                ;; 
    Bytes_sent) 
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} extended-status 2>/dev/null |grep -w "Bytes_sent" |cut -d"|" -f3` 
                echo $result 
                ;; 
    Bytes_received) 
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} extended-status 2>/dev/null |grep -w "Bytes_received" |cut -d"|" -f3` 
                echo $result 
                ;; 
    Com_begin) 
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} extended-status 2>/dev/null |grep -w "Com_begin"|cut -d"|" -f3` 
                echo $result 
                ;;
    Threads_running)
        result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} extended-status 2>/dev/null |grep -w "Threads_running"|cut -d"|" -f3`
                echo $result 
                ;;                      
    Seconds_Behind_Master)
        result=`$mysql -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} -e "show slave status\G" 2>/dev/null |grep Seconds_Behind_Master |awk '{print $2}'`
                echo $result
                ;;
    Slave_IO_Running)
        result=`$mysql -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} -e "show slave status\G" 2>/dev/null |grep Slave_IO_Running |awk '{print $2}'`
                echo $result
                ;;
    Slave_SQL_Running)
        result=`$mysql -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} -e "show slave status\G" 2>/dev/null |grep "Slave_SQL_Running:" |awk '{print $2}'`
                echo $result
                ;;
        *)
	result=`$mysqladmin -h ${MYSQLIP} -P ${MYSQLPORT} -umonitor -p${MYSQL_PWD} extended-status 2>/dev/null |grep -w "$2"|cut -d"|" -f3`
		echo $result 
        	;; 
esac 
