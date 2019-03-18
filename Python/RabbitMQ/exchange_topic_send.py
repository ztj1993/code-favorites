# -*- coding: utf-8 -*-
# Author: Ztj

import time

from common import channel, connection

channel.exchange_declare(exchange='exchange_topic_exchange', exchange_type='topic')

body = 'Hello World! - %s' % time.time()

channel.basic_publish(
    exchange='exchange_topic_exchange',
    routing_key='one.two',
    body=body,
)
print(" [x] Sent '%s'" % body)
connection.close()
