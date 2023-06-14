#!/usr/bin/env python3
# -*- coding: utf-8 -*-


import requests
import os
from datetime import datetime


#start from date
now =datetime.now()
date_string = now.strftime("%Y-%m-%d")


# link path

script_dir = "" 
#or #script_dir = os.path.dirname(os.path.abspath(__file__))




#key_file = os.path.join(script_dir, "key.txt")
#with open(key_file, "r") as key_file:
#    key = key_file.read().strip()


url = "https://hlwicpfwc.miit.gov.cn/icpproject_query/api/icpAbbreviateInfo/queryByCondition/"
#key = "1f2a71f62d81a8cef7761ced6c355e4d"  # 申请的key


filename = os.path.join(script_dir, "domain_list.txt")
#filename = "/Users/steven/Desktop/ceshicunchu/api/domain_list.txt"

# 读取域名列表
with open(filename, "r") as file:
    for domain in file:
        domain = domain.strip()
        response = requests.get(f"{url}{domain}")
        result_data = response.json()

        print(result_data)
