#!/bin/bash
IP=$1
scp_agent()
{
sshpass -p 'qZ0ye4uv$rH{' ssh -o StrictHostKeyChecking=no zabbix@"$IP" "sudo /etc/init.d/zabbix_agentd stop"
sshpass -p 'qZ0ye4uv$rH{' scp -r /usr/local/zabbix zabbix@"$IP":/usr/local/ 
sshpass -p 'qZ0ye4uv$rH{' ssh -o StrictHostKeyChecking=no zabbix@"$IP" "sudo /etc/init.d/zabbix_agentd start"

}
scp_agent
echo "#########redis_check############"
/usr/local/zabbix/bin/zabbix_get -s $IP -k redis.discovery
echo "#########zookeeper_check############"
/usr/local/zabbix/bin/zabbix_get -s $IP -k zookeeper.status[alive,127.0.0.1,2181]
echo "#########disk_check############"
/usr/local/zabbix/bin/zabbix_get -s $IP -k discovery.disks.iostats
echo "#########mysql_check############"
/usr/local/zabbix/bin/zabbix_get -s $IP -k discovery.mysql.port


########################
#sshpass -p 'D:eR(o64iysm' ssh -o StrictHostKeyChecking=no zabbix@
#sshpass -p 'qZ0ye4uv$rH{' ssh -o StrictHostKeyChecking=no zabbix@
