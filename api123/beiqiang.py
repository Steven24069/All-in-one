#!/usr/bin/env python3
# -*- coding: utf-8 -*-


import requests
import os
from datetime import datetime


#start from date
now =datetime.now()
date_string = now.strftime("%Y-%m-%d")

# link path
script_dir = os.path.dirname(os.path.abspath(__file__))

log_file = os.path.join(script_dir, "log", "log_domain")
normal_file = os.path.join(script_dir, "log", "1.txt")
block_file = os.path.join(script_dir, "log", "2.txt")
test_fail = os.path.join(script_dir, "log", "3.txt")
non_file = os.path.join(script_dir, "log", "4.txt")
rizhi = os.path.join(script_dir, "rizhi", "beiqiang.txt")


key_file = os.path.join(script_dir, "key.txt")
with open(key_file, "r") as key_file:
    key = key_file.read().strip()

url = "https://api.boce.com/v3/task/create/wall"
#key = "1f2a71f62d81a8cef7761ced6c355e4d"  # 申请的key

#filename = "/Users/steven/Desktop/ceshicunchu/api/domain_list.txt"
filename = os.path.join(script_dir, "domain_list.txt")

# 读取域名列表
with open(filename, "r") as file:
    for domain in file:
        domain = domain.strip()
        response = requests.get(f"{url}?key={key}&host={domain}")

        # 解析JSON响应
        data = response.json().get("data")

        # 提取域名和值
        domain_value = list(data.keys())[0]
        value = data[domain_value]

        # 输出结果
        #print(f"Domain: {domain_value} , Value: {value}")

        with open(log_file, "a") as log:
            log.write(f"Domain: {domain_value} , Value: {value}\n")

def check_domains(log_file, normal_file, block_file, test_fail, non_file):
    with open(log_file, 'r') as file:
        lines = file.readlines()

    with open(normal_file, 'w') as file_1, open(block_file, 'w') as file_2, open(test_fail, 'w') as file_3, open(non_file, 'w') as file_4 :
        for line in lines:
            line = line.strip()
            domain_start_index = line.find('Domain: ') + len('Domain: ')
            value_start_index = line.find('Value: ') + len('Value: ')
            domain = line[domain_start_index:line.find(' , Value:')]
            value = line[value_start_index:]
            if value.strip() == '0':
                file_1.write(f"{domain}\n")
            elif value.strip() == '1':
                file_2.write(f"{domain}\n")
            elif value.strip() == '2':
                file_3.write(f"{domain}\n")
            elif value.strip() == '3':
                file_4.write(f"{domain}\n")

check_domains(log_file, normal_file, block_file, test_fail, non_file )

with open(normal_file, 'r') as file_1:
    print("-----域名正常:")
    print(file_1.read())

with open(block_file, 'r') as file_2:
    print("-----被墙:")
    print(file_2.read())

with open(test_fail, 'r') as file_3:
    print("-----疑似被墙 :")
    print(file_3.read())

with open(non_file, 'r') as file_4:
    print("-----无资源请重试) :")
    print(file_4.read())


#日志- logfile
with open(rizhi, 'a') as log,  open(normal_file, 'r') as file_1, open(block_file, 'r') as file_2, open(test_fail, 'r') as file_3, open(non_file, 'r') as file_4:
    log.write(date_string)
    log.write("\n")
    log.write("-----域名正常: \n")
    log.write(file_1.read())
    log.write("-----被墙: \n")
    log.write(file_2.read())
    log.write("-----疑似被墙 : \n")
    log.write(file_3.read())
    log.write("-----无资源请重试) : \n")
    log.write(file_4.read())



line_count = 0
with open(log_file, 'r') as file:
    for line in file:
        line_count +=1
print(f"总共检查 ： {line_count} 个域名 ")


with open(normal_file, 'w') as file_1:
    pass
with open(block_file, 'w') as file_2:
    pass
with open(test_fail, 'w') as file_3:
    pass
with open(non_file, 'w') as file_4:
    pass
with open(log_file, 'w') as file:
    pass