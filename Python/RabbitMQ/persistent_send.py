# -*- coding: utf-8 -*-
# Author: Ztj

import time

from common import channel, connection, pika

channel.queue_declare(queue='persistent_queue')

body = 'Hello World! - %s' % time.time()

channel.basic_publish(
    exchange='',
    routing_key='persistent_routing_key',
    body='Hello World! - %s' % time.time(),
    properties=pika.BasicProperties(delivery_mode=2, ),
)
print(" [x] Sent '%s'" % body)
connection.close()
