from flask import Flask
from zabbix_core import *
from flask_restful import Resource,Api,reqparse

app = Flask(__name__)
api = Api(app)

zabbix = ZabbixLogin(url="http://172.28.5.125/zabbix", user="admin", password="zabbix")
auth = zabbix.login()
function = ZabbixAPI(url="http://172.28.5.125/zabbix",auth=auth)

class HostInfo(Resource):
    def get(self,host=""):
        return function.host_get(host=host),200



        # parser = reqparse.RequestParser()
        # parser.add_argument('host', type=str, location='args')
        # args = parser.parse_args()
        #


api.add_resource(HostInfo,'/hosts/','/hosts/<host>',endpoint='todo_ep')
#api.add_resource(HostInfo,'/host/<string:host>')

# @app.route('/')
# def hello_world():
#     return str(function.host_get())



if __name__ == '__main__':
    app.run()
