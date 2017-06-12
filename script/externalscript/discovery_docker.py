#!/usr/bin/env python
# -*- coding:utf8 -*-
__author__ = '王艳艳'

import os
import json

# t=os.popen("sudo netstat -tlpn |grep redis-ser|grep 0.0.0.0|awk '{print $4}'|awk -F: '{print $2}' ")
t=os.popen("sudo cat /tmp/check_docker_ret |awk '{print $1}'")

name = []
for item in t.readlines():
        name.append({'{#INSTANCE}':item.strip()})
print json.dumps({'data':name},sort_keys=True,indent=4,separators=(',',':'))
