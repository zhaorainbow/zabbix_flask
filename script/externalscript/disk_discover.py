#!/usr/bin/python
 
import os
import json
 
data = {}
diskname_list = []
disk_list=[]
 
command = '''iostat |awk '{print $1}'| grep ^[vd]'''
 
lines = os.popen(command).readlines()
 
for line in lines:
        disk_name =  line.strip('\n')
        disk_list.append(disk_name)
 
for disk_name in list(set(disk_list)):
        disk_dict = {}
        disk_dict['{#DISK_NAME}'] = disk_name
        diskname_list.append(disk_dict)
 
data['data'] = diskname_list
 
 
jsonStr = json.dumps(data, sort_keys=True, indent=4)
 
print jsonStr
