#! /bin/bash
#Create by PQL 2015.11.07
PROGNAME=`/bin/basename $0`
PROGPATH=`echo $0 | sed -e 's,[\\/][^\\/][^\\/]*$,,'`
file_num=0
detail=""



case $1 in
	Root)
		detail=`sudo sh -c 'lsof -n 2>/dev/null'|awk '{print $3}'| grep 'root' |wc -l`
		file_num=`echo $detail|awk '{print $1}'`
		echo $file_num
		;;
	Docker)
		detail=`sudo sh -c 'lsof -n 2>/dev/null'|awk '{print $3}'| grep '501' |wc -l`
		file_num=`echo $detail|awk '{print $1}'`
		echo $file_num
		;;
	System)
		file_num=`sudo sh -c "cat /proc/sys/fs/file-nr"| awk '{print $1}'`
		echo $file_num
		;;
	*)
		echo "Usage:$0(User|System|Docker)" 
        	;;
esac
