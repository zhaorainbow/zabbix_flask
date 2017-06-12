#!/usr/bin/env python
# -*- encoding: utf-8 -*-
import requests, logging, urllib, argparse, sys, json
logging.basicConfig(level=logging.INFO, format='%(asctime)s | %(levelname)s | %(message)s')

CONF = {
    'gateway'   : 'http://gateway.iems.net.cn/GsmsHttp',
    'username'  : '69406:admin',
    'password'  : 'sy5w1n',
    'to'        : '13811296115',
    'content'   : '',
}


def arguments():
    # parser = argparse.ArgumentParser(usage='''
    #     cat content.txt | python sms.py -n "130111111,130222222"
    #     python sms.py -f content.txt -n "130111111,130222222"''')
    # parser.add_argument('-f', dest='file', help='file content as SMS text')
    # parser.add_argument('-n', dest='number', help='phone number to send, as "13011111111,13022222222"')
    # parser.add_argument('-u', dest='username', help='user name, as ID:USERNAME')
    # parser.add_argument('-p', dest='password', help='password')
    # args = parser.parse_args()

    # if args.number:
    #     CONF['to'] = args.number
    if sys.argv[1]:
        CONF['to'] = sys.argv[1]
    print CONF
    # if args.username:
    #     CONF['username'] = args.username
    # if args.password:
    #     CONF['password'] = args.password

    # if args.file:
    #     with open(args.file) as f:
    #         text = f.read()
    # else:
    #     text = sys.stdin.read()

    if sys.argv[3]:
        text = sys.argv[3]
    return text


def send(text):
    content = text.decode('utf8').encode('gbk')
    CONF['content'] = urllib.quote(content)
    print CONF
    logging.debug(json.dumps(CONF, indent=1))
    resp = requests.get('{gateway}?username={username}&password={password}&to={to}&content={content}'.format(**CONF))
    logging.info(resp.status_code)
    logging.info(resp.content)


if __name__ == '__main__':
    text = arguments()
    send(text)
