# -*- coding: utf-8 -*-
# Author: Ztj

import time

from common import channel, connection

channel.queue_declare(queue='hello_queue')

body = 'Hello World! - %s' % time.time()

channel.basic_publish(
    exchange='',
    routing_key='hello_routing_key',
    body=body,
)
print(" [x] Sent '%s'" % body)
connection.close()
