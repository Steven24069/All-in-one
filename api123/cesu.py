#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests
import time
import os
from datetime import datetime


#start from date
now =datetime.now()
date_string = now.strftime("%Y-%m-%d")

# link path
script_dir = os.path.dirname(os.path.abspath(__file__))
rizhi = os.path.join(script_dir, "rizhi", "cesu.txt")

# API endpoints
#create_url = "https://api.boce.com/v3/task/create/curl"
#result_url = "https://task.boce.com/v3/task/hijack"

key_file = os.path.join(script_dir, "key.txt")
with open(key_file, "r") as key_file:
    api_key = key_file.read().strip()

# Authorization key
#api_key = "0638e2614857864c4b41c26899136c02"

# Node ID list
node_ids = "31,32,13,14,19,20,2"
#node_ids = "6,7,8,12,13,14,19,20,24,25,26,30,31,32,36,37,38,42,43,48,49,54,55,60,61,62,66,67,72,73,74,79,80,84,85,86,90,91,92,96,97,98,102,103,104,108,110,114,115,116,120,121,122,126,127,128,132,133,134,138,139,144,145,146,150,151,152,156,157,162,163,164,168,169,174,180,181,80044,80046,80053,80062,80066,80070,80090,80097,80164,80168,80169,80174,80176,80912,80913,80914,80915"
# Domain list file
filename = os.path.join(script_dir, "domain_list.txt")

#filename = "domain_list.txt"

# Read domain list from file
with open(filename, "r") as file:
    domains = file.readlines()


with open(rizhi, 'a') as file:
    file.write(date_string)
    file.write("\n")



    for domain in domains:
        domain = domain.strip()
        print("-------------------------------")
        print("-------------------------------")
        print("Domain:", domain)  # Print the domain

        file.write("---------域名 ： " + domain + "\n")

    # Create task
        results = []
#for domain in domains:
        create_task_url = f"https://api.boce.com/v3/task/create/curl?key={api_key}&node_ids={node_ids}&host={domain}"
        create_response = requests.get(create_task_url)
        task_data = create_response.json()
    

    # Parse create task response
        create_error_code = task_data.get("error_code")
        create_data_id = task_data.get("data", {}).get("id")
        create_error = task_data.get("error")

    #Print create task result
    #print("Create Task Result:"
    #print(task_data)
    #print("error_code:", create_error_code)
    #print("data.id:", create_data_id)
    #print("error:", create_error)
    #print()

    # Get Result
    #done_status = False
        false_count = 0 
        while True:

            result_url = f"https://api.boce.com/v3/task/curl/{create_data_id}?key={api_key}"
            result_response = requests.get(result_url)
            result_data = result_response.json()


            done_status = result_data.get("done")

        #host = result_data.get("list", [{}])[0].get("hijack")
    #error_code = result_data.get(["list"][0]["hijack"])

        #print(result_data)
            print("是否检查成功 :", done_status)

        

        #print("是否被劫持 :", host) #	是否被劫持,true被劫持,false未被劫持
            if done_status == True :
                for item in result_data.get('list', []):
                    node_name = item.get('node_name')
                    error_code = item.get('error_code')
                    ip_region = item.get('ip_region')


                    if ip_region == "本机地址本机地址" :
                    
                        print("节点有问题 ：", node_name)
                        file.write("节点有问题 ：" + node_name + "\n")

                    elif ip_region == "*" :
                        print("节点有问题 ：", node_name)
                        file.write("节点有问题 ：" + node_name + "\n")

                    #print(ip_region)
                #print(error_code)

            #if hijack == True: #------------------

                #print("	是否被劫持,true被劫持,false未被劫持 :", hijack)
            #    print("	被劫持的地区名称 :", node_name)
            #else: false_count += 1
            #if not done_status :
            #    false_count +=1
            #    if false_count >4 :    
            #        break
            #elif hijack == False:
            #    print("域名正常") 
        #print("是否被劫持 :", host) #	是否被劫持,true被劫持,false未被劫持


        # Check if task is done
            if done_status:
                break


            false_count += 1            
            if false_count > 3:
                break

        # Wait for 5 seconds before requesting task result again
            time.sleep(30)
        # Check if task is done



