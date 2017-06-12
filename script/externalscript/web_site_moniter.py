#!/usr/bin/env python
# coding:utf-8

import os, sys, json

# 将要监控的web站点url添加到urllist列表
# urllist = ["http://baidu.com",
#            "http://www.qq.com",
#            "http://www.sina.com.cn/"]
files='/usr/local/zabbix/share/zabbix/externalscript/url.txt'

fd = open(files,'r')
urllist=[]
for i in fd.readlines():
    if i[0] != '#':
        urllist.append(i.strip('\n'))
fd.close()

# 这个函数主要是构造出一个特定格式的字典，用于zabbix
def web_site_discovery():
    web_list = []
    web_dict = {"data": None}

    for url in urllist:
        url_dict = {}
        url_dict["{#SITENAME}"] = url
        web_list.append(url_dict)

    web_dict["data"] = web_list
    jsonStr = json.dumps(web_dict, sort_keys=True, indent=4)
    return jsonStr


# 这个函数用于测试站点返回的状态码，注意在cmd命令中如果有%{}这种字符要使用占位符代替，否则
# 会报错
def web_site_code():
    cmd = 'curl --connect-timeout 5 -m 10 -o /dev/null -s -w %s %s' % ("%{http_code}", sys.argv[2])
    reply_code = os.popen(cmd).readlines()[0]
    return reply_code


def web_site_time():
    cmd = 'curl --connect-timeout 5 -m 10 -o /dev/null -s -w %s %s' % ("%{time_connect}", sys.argv[2])
    reply_code =float('%0.3f'%float(os.popen(cmd).readlines()[0]))*1000
    return reply_code


if __name__ == "__main__":
    try:
        if sys.argv[1] == "web_site_discovery":
            print web_site_discovery()
        elif sys.argv[1] == "web_site_code":
            print web_site_code()
        elif sys.argv[1] == "web_site_time":
            print int(web_site_time())
        else:
            print "Pls sys.argv[0] web_site_discovery | web_site_code[URL] | web_site_time[URL]"
    except Exception as msg:
        print msg
