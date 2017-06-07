# -*- coding: utf-8 -*-
import requests ,sys
import urllib2,urllib
import json
import pycurl
class Zabbix_Wecaht(object):
    def __init__(self):
        #self.url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=wx8f2b94c264850892&corpsecret=sECdwF32qpuQ-h5OBygFXfhaEvzZqZMSqSN7avdS3t4qzRRmZuT2z9GM5_oLXzZ6"
        self.url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken"
        self.data = {
            "corpid":"wx8f2b94c264850892",
            #"corpsecret":"6xrWYISrvGtWhZAjMxfva9Z9Z_e0NCvVYnFrAbD9JaI"
            "corpsecret": "hrYi29y9NNTlcY46PITJ5qq8LgvM3yxOma8XcRiivfo"
        }
        self.access_token = self.get_token()
        self.cookie = "./cookie"

    def get_token(self):
        r = requests.get(url=self.url, params=self.data)
        result = r.json()["access_token"]
        return result

    def send_message(self,content):
        message_url = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=%s" % self.access_token
        message_data = {
                "touser":"@all",
                "toparty":"@all",
                "totag":"@all",
                "msgtype": "text",
                "agentid":"1",
                "text": {
                    "content":content
            }
        }
        r = requests.post(url=message_url,json=message_data)
        return  r.json()
class zabbix_API(object):
    def __init__(self):
        self.zabbix_url = "http://172.28.5.125/zabbix/api_jsonrpc.php"
        self.user = "admin"
        self.password = "zabbix"
        self.data = {
            "jsonrpc": "2.0",
            "method": "user.login",
            "params": "null",
            "id": 1,
        }
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

    def get_image(self):
        c =Zabbix_Wecaht()
        c.access_token


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
    #wechat = Zabbix_Wecaht()
    #wechat.send_message(content=sys.argv[3])
    zabbix = zabbix_API()
    hostid = zabbix.get_hostid("127.0.0.1")
    iteam = zabbix.get_iteamid(hostid,"agent.ping")
    wechat =

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
