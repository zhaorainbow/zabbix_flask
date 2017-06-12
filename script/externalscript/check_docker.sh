#!/bin/sh
## Version 1 Create by WangYanYan on 20161205

name=$1
key=$2

case $key in
cpu)
    result=`sudo cat /tmp/check_docker_ret |grep $name |awk '{print $2}'|sed 's/%//g'`
    echo $result;;
memory)
    result=`sudo cat /tmp/check_docker_ret |grep $name |awk '{print $3}'|sed 's/%//g'`
    echo $result;;
disk)
    result=`sudo cat /tmp/check_docker_ret |grep $name |awk '{print $4}'|sed 's/%//g'`
    echo $result;;
netIn)
    result=`sudo cat /tmp/check_docker_ret |grep $name |awk '{print $5}'|awk -F '[' '{print $1}`
    echo $result;;
netOut)
    result=`sudo cat /tmp/check_docker_ret |grep $name |awk '{print $5}'|awk -F '/' '{print $2}' |awk -F '[' '{print $1}`
    echo $result;;
*)
    echo "Usage:$0 (cpu|memory|disk|net)";;
esac
