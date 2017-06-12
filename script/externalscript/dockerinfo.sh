#!/bin/sh
#Create by PQL 2015.11.10
PROGNAME=`/bin/basename $0`
huansuan(){
case $temp2 in
        MB)
        beishu=1024
        ;;
	GB)
	beishu=1048576
	;;
	TB)
	beishu=1073741824
	;;
esac
}

case $1 in
	Containers)
		result=`/usr/bin/docker info |grep 'Containers'|awk '{print $2}'`
		echo $result
		;;
	Images)
		result=`/usr/bin/docker info |grep 'Images'|awk '{print $2}'`
                echo $result
                ;;
	DataUsed)
		tempdata=`/usr/bin/docker info |grep 'Data Space Used'|awk '{print $4,$5}'`
		temp1=`echo $tempdata|awk '{print $1}'`
		temp2=`echo $tempdata|awk '{print $2}'`
		huansuan
		result=$(echo "$temp1 * $beishu" |bc |awk -F '.' '{print $1}')
		echo $result
                ;;
	DataTotal)
		tempdata=`/usr/bin/docker info |grep 'Data Space Total'|awk '{print $4,$5}'`
                temp1=`echo $tempdata|awk '{print $1}'`
                temp2=`echo $tempdata|awk '{print $2}'`
                huansuan
                result=$(echo "$temp1 * $beishu" |bc |awk -F '.' '{print $1}')
                echo $result
                ;;
        MetadataUsed)
                tempdata=`/usr/bin/docker info |grep 'Metadata Space Used'|awk '{print $4,$5}'`
                temp1=`echo $tempdata|awk '{print $1}'`
                temp2=`echo $tempdata|awk '{print $2}'`
                huansuan
                result=$(echo "$temp1 * $beishu" |bc |awk -F '.' '{print $1}')
                echo $result
                ;;
        MetadataTotal)
                tempdata=`/usr/bin/docker info |grep 'Metadata Space Total'|awk '{print $4,$5}'`
                temp1=`echo $tempdata|awk '{print $1}'`
                temp2=`echo $tempdata|awk '{print $2}'`
                huansuan
                result=$(echo "$temp1 * $beishu" |bc |awk -F '.' '{print $1}')
		echo $result
                ;;
        *)
                echo "Usage:$0(Containers|Images|DataUsed|DataTotal|MetadataUsed|MetadataTotal)" 
                ;;
esac
