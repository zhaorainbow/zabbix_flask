# -*- coding: utf-8 -*-
import requests ,sys,os,datetime,re
import urllib2,urllib
import json
import pycurl
class Zabbix_Wecaht(object):
    def __init__(self):
        #self.url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=wx8f2b94c264850892&corpsecret=sECdwF32qpuQ-h5OBygFXfhaEvzZqZMSqSN7avdS3t4qzRRmZuT2z9GM5_oLXzZ6"
        self.url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken"
        self.data = {
            "corpid":"wx8f2b94c264850892",
            "corpsecret":"6xrWYISrvGtWhZAjMxfva9Z9Z_e0NCvVYnFrAbD9JaI"
            #"corpsecret": "hrYi29y9NNTlcY46PITJ5qq8LgvM3yxOma8XcRiivfo"
        }
        self.access_token = self.get_token()

    def get_token(self):
        r = requests.get(url=self.url, params=self.data)
        result = r.json()["access_token"]
        return result

    def send_message(self,title,media_id,content):
        message_url = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=%s" % self.access_token
        message_data = {
                "touser":"@all",
                "toparty":"@all",
                "totag":"@all",
                "msgtype": "mpnews",
                "agentid":"1000002",
		"mpnews": {
              	  "articles": [
                	{
                    	"title": title,
                    	"thumb_media_id": media_id,
                    	"author": "zabbix",
                    	"content_source_url": "URL",
                    	"content": content,
                    	"digest": content,
                    	"show_cover_pic": "1"
                	},
           	 ]	
        	},
		"safe":0
            }
	print message_data
	print message_url
        r = requests.post(url=message_url,json=message_data)
        return  r.json()
class zabbix_API(object):
    def __init__(self):
        self.zabbix_url = "http://10.253.68.70/zabbix/api_jsonrpc.php"
        self.zabbix_index = "http://10.253.68.70/zabbix/index.php"
        self.zabbix_chart = "http://10.253.68.70/zabbix/chart.php"
        self.user = "weixin"
        self.password = "syswin123"
        self.data = {
            "jsonrpc": "2.0",
            "method": "user.login",
            "params": "null",
            "id": 1,
        }
        self.cookie = "/tmp/cookie"
#获取认证
    def get_auth(self):
        data = {'params': {'password':self.password, 'user': self.user}, 'jsonrpc': '2.0', 'method': 'user.login', 'id': 1}
        r = requests.post(url=self.zabbix_url,json=data)
        auth = r.json()["result"]
        return auth

# zabbix api通过ip获取主机id
    def get_hostid(self,ip):
        self.data["method"] = "host.get"
        self.data["auth"] = self.get_auth()
        self.data["params"] = {"output":["host"],"filter": {'ip':ip } }
        r = requests.post(url=self.zabbix_url,json=self.data)
        return r.json()["result"][0]["hostid"]

    def get_iteamid(self,hostid,key):
        self.data["method"] = "item.get"
        self.data["auth"] = self.get_auth()
        self.data["params"] = {"output": "itemid","hostids": hostid,"search":{"key_":key}}
        r = requests.post(url=self.zabbix_url, json=self.data)
        return r.json()["result"][0]["itemid"]

    def get_image(self,iteamid,access_token):
	timedata = datetime.datetime.now() - datetime.timedelta(hours=1)
	stime = timedata.strftime("%Y%m%d%H%M%S")
	imagename = "/tmp/image/%s.png" % (stime)
        curlcookie = 'curl -o /dev/null -c %s -b %s -d "name=%s&password=%s&autologin=1&enter=Sign+in" %s' % (self.cookie,self.cookie,self.user,self.password,self.zabbix_index)
	os.system(curlcookie)
	curlimage = 'curl -b %s -d "itemids=%s&period=1800&weidth=800" -o %s %s' % (self.cookie,iteamid,imagename,self.zabbix_chart)
	#print curlimage
	os.system(curlimage)
	upload_url  = "https://qyapi.weixin.qq.com/cgi-bin/media/upload?access_token=%s&type=image" % access_token
	upload_data = {"media":open(imagename,'rb')} 
	r = requests.post(url=upload_url,files=upload_data)
	return r.json()["media_id"]
	 
#	print stime


# def get_token(self):
    #     req = urllib2.Request(self.url,self.data)
    #     print urllib.urlencode(self.url,self.data)
    #     res = urllib2.urlopen(req)
    #     value = res.read()
    #     print value
    #     return value
    # def get_token(self):
    #     response = urllib2.urlopen(url=self.url,data=self.data)
    #     return  json.loads(response.read())["access_token"]

if __name__ == "__main__":
    ip = str(sys.argv[1])
    key = str(sys.argv[2])
    content = str(sys.argv[3])
    print content
    #key = re.findall(r"告警项目:(.+?)<br>", content)[0]
    #print key
    wechat = Zabbix_Wecaht()
    #wechat.send_message(content=sys.argv[3])
    zabbix = zabbix_API()
    hostid = zabbix.get_hostid(ip)
    iteamid =  zabbix.get_iteamid(hostid,key)
    media_id = zabbix.get_image(iteamid,wechat.access_token)
    title = "alarm"
    print    wechat.send_message(title,media_id,content)
    # print zabbix.get_auth()
# class Zabbix_Wecaht(object):
#     def __init__(self):
#         self.url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken"
#         self.gettoken_data = {
#             "corpid": "wx8f2b94c264850892",
#             "corpsecret": "sECdwF32qpuQ-h5OBygFXfhaEvzZqZMSqSN7avdS3t4qzRRmZuT2z9GM5_oLXzZ6",
#             }
#
#
#     def GetToken(self):
#         request = urllib2.Request(url=self.url,data=urllib.urlencode(self.gettoken_data))
#         response = urllib2.urlopen(request)
#         print  response.read()
#
# zabbix = Zabbix_Wecaht()
# print zabbix.GetToken()
