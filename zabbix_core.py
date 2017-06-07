# -*- coding: utf-8 -*-

import urllib2
import json
import requests
class ZabbixLogin(object):
    def __init__(self,url,user,password):
        self.headers = {"Content-Type":"application/json"}
        self.request_data = {
            "jsonrpc": "2.0",
            "method": "user.login",
            "params": "null",
            "id": 1,
        }
        self.user =user
        self.password = password
        self.url = url + "/api_jsonrpc.php"

    def login_request(self,method,params):
        self.request_data["method"] = method
        self.request_data["params"] = params
        request = urllib2.Request(url=self.url, data=json.dumps(self.request_data), headers=self.headers)
        try :
            response = urllib2.urlopen(request)
            result = json.loads(response.read())
            return result
        except Exception as e:
            print e

    def login(self):
        method = "user.login"
        params = {"user": self.user, "password": self.password}
        return self.login_request(method,params)["result"]

class ZabbixAPI(object):
    def __init__(self,url,auth):
        self.headers = {"Content-Type":"application/json"}
        self.request_data = {
            "jsonrpc": "2.0",
            "method": "user.login",
            "params": "null",
            "id": 1,
        }
        self.url = url + "/api_jsonrpc.php"
        self.auth = auth

    def deal_request(self,method,params,auth):
        self.request_data["method"] = method
        self.request_data["params"] = params
        self.request_data["auth"] = auth
        request = urllib2.Request(url=self.url, data=json.dumps(self.request_data), headers=self.headers)
        try :
            response = urllib2.urlopen(request)
            result = json.loads(response.read())
            return result
        except Exception as e:
            print e

    def ip_get(self,HostID=''):
        method = "hostinterface.get"
        params = {"output":["ip","hostid","port"],"filter": {"hostid": HostID}}
        auth = self.auth
        if len(HostID) == 0 :
            return self.deal_request(method, params, auth)["result"]
        else:
            for IP in self.deal_request(method, params, auth)["result"]:
                return IP
    def group_get(self):
        method = "hostgroup.get"
        params = ''




    def host_get(self,host=""):
        method = "host.get"
        params = {"output":["available","host","groups"],"selectParentTemplates":["name"],"selectGroups":["name"],"filter":{"host":host}}
        auth = self.auth
        if len(host) == 0:
            return self.deal_request(method, params, auth)["result"]
        else :
            for host in self.deal_request(method, params, auth)["result"]:
                host["ip"] = self.ip_get(HostID=host["hostid"])["ip"]
                host["port"] = self.ip_get(HostID=host["hostid"])["port"]
                return  host













zabbix = ZabbixLogin(url="http://172.28.5.125/zabbix", user="admin", password="zabbix")
auth = zabbix.login()
function = ZabbixAPI(url="http://172.28.5.125/zabbix",auth=auth)
print function.host_get("172.28.20.26")
#print function.ip_get()
#print zabbix.login()
















    # def deal_request(self,method,params):
    #     self.request_data["method"] = method
    #     self.request_data["params"] = params
    #     self.request_data["auth"] = self.login()
    #     request = urllib2.Request(url=self.url, data=json.dumps(self.request_data), headers=self.headers)
    #     try :
    #         response = urllib2.urlopen(request)
    #         result = json.loads(response.read())
    #         return result
    #     except Exception as e:
    #         print e
    #
    # def get_host(self):
    #     method = "host.get"
    #     params = {
    #         "output": "extend",
    #         "filter": {
    #             "host": ["172.28.20.26"]
    #         }
    #     }
    #     auth = self.auth
    #     return self.deal_request(method,params,auth)





#print str(zabbix.test())