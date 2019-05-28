# -*- coding: utf-8 -*-
# Author: Ztj

import pika

username = 'test_user'
password = 'test_pwd'

# 认证
credentials = pika.PlainCredentials(username, password)

# 连接
connection = pika.BlockingConnection(pika.ConnectionParameters(host='192.168.120.116', credentials=credentials))

# 通道
channel = connection.channel()
