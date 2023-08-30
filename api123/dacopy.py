#!/usr/bin/env python3
# -*- coding: utf-8 -*-


import requests
import os
from datetime import datetime


# Authorization key
api_key = "0638e2614857864c4b41c26899136c02"


url = "https://task.boce.com/v3/node/list"
#key = "1f2a71f62d81a8cef7761ced6c355e4d"  # 申请的key


response = requests.get(f"{url}?key={api_key}")
result_data = response.json()
print (result_data)