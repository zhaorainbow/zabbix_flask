#!/bin/sh 
#Create by PQL 2015.11.5 
case $1 in
        tcp)
                result=($(/usr/sbin/ss -s| head -2 |tail -1|grep -oP "\d+"|head -1 |tail -1))
                echo $result 
                ;;
        estab)
                result=($(/usr/sbin/ss -s| head -2 |tail -1|grep -oP "\d+"|head -2 |tail -1))
                echo $result
                ;;
        closed)
                result=($(/usr/sbin/ss -s| head -2 |tail -1|grep -oP "\d+"|head -3 |tail -1))
                echo $result
                ;;
        orphaned)
                result=($(/usr/sbin/ss -s| head -2 |tail -1|grep -oP "\d+"|head -4 |tail -1))
                echo $result
                ;;
        synrecv)
                result=($(/usr/sbin/ss -s| head -2 |tail -1|grep -oP "\d+"|head -5 |tail -1))
                echo $result
                ;;
        timewait)
                result=($(/usr/sbin/ss -s| head -2 |tail -1|grep -oP "\d+"|head -6 |tail -1))
                echo $result
                ;;
        http)
                result=($(ss -o state established '( dport = :http or sport = :http )'|egrep -v 'Recv-Q'|wc -l))
                echo $result
                ;;
        *)
        echo "Usage:$0(tcp|estab|closed|orphaned|synrecv|timewait|http)" 
        ;;
esac
