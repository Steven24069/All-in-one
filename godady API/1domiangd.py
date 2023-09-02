#!/usr/bin/env python3
# -*- coding: utf-8 -*-



import requests
import time
import os
import urllib.request
import json

filename = "domain_list.txt"

#读取用户输入
#domain_addr = input(str('输入域名：'))
#ip_addr = input(str('输入IP地址：'))
#ip_addm = input(str('输入IP地址 m ：'))

#定义请求地址
api_key = "gH9tTdiRutpc_CbYo4tuTqEfSpy1WRrj2Hj"
secret_key = "KVSLPtRswS7qZXyeiB1Kua"


domain = input("请输入域名: ")
record_type = input("输入Type (A, CNAME, TXT, ...): ")
record_name = input("输入Record name( @, www, m, ...): ")
ip_addr = input(str('输入IP地址：'))

api_url = f'https://api.godaddy.com/v1/domains/{domain}/records/{record_type}/{record_name}';
#api_url = 'https://api.godaddy.com/v1/domains/wqtv7.com/records/A/abc';

#new_url = api_url.replace("pcserver.me", filename)


def update_NS(api_url, ip_addr):
    #定义http请求头
    head = {}
    #定义服务器返回json数据给我们
    head['Accept'] = 'application/json'
    #定义我们发送的数据为json
    head['Content-Type'] = 'application/json'
    #定义身份认证信息
    head['Authorization'] = "sso-key {}:{}".format(api_key, secret_key)

    #定义解析记录
    records_a = {
    "data" : ip_addr,
    "name" : "update",
    "ttl" : 600,
    "type" : 'A',
    }

    #定义需要发送给服务器的数据为put_data这个列表，包含上面的解析记录
    #put_data = [records_a]
    put_data = [records_a]
    #错误处理
    try:
        #定义请求，包含请求地址，请求头，请求方式，并把put_data从json转换为字符串格式，再转换成bytes
        #req = urllib.request.Request(api_url,headers = head,data = json.dumps(put_data).encode(),method = "PATCH")
        req = urllib.request.Request(api_url,headers = head,data = json.dumps(put_data).encode(),method = "PUT")
        rsp = urllib.request.urlopen(req)
        #根据官方文档我们只需要知道服务器返回码即可，200为成功，这里获取服务器的返回码
        code = rsp.getcode()
        #判断是否成功
        if code == 200:
            print('成功更改域名解析：'+ip_addr)
            #print('成功更改域名解析：'+ip_addm)
        else:
            print('更改失败！')
    #原谅我偷懒。官方有400/401/422等错误，这里统一处理了
    except:
        print('错误！')

#执行一下函数，并传入请求地址和我们输入的IP
update_NS(api_url,ip_addr)
#update_NS(api_url,ip_addm)
