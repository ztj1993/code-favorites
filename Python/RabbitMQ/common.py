# -*- coding: utf-8 -*-
# Author: Ztj

import pika

username = 'test_user'
password = 'test_pwd'
credentials = pika.PlainCredentials(username, password)
connection = pika.BlockingConnection(pika.ConnectionParameters(host='192.168.120.116', credentials=credentials))
channel = connection.channel()
