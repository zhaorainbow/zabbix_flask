#!/bin/bash
port=$1
result=`netstat -lntup | grep $port |wc -l`
if [[ $result -eq 0 ]] ;then
	echo 0
else
	echo 1
fi

#echo $result
#echo $port
