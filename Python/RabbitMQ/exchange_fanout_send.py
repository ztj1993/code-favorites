# -*- coding: utf-8 -*-
# Author: Ztj

import time

from common import channel, connection

channel.exchange_declare(exchange='exchange_fanout_exchange', exchange_type='fanout')

body = 'Hello World! - %s' % time.time()

channel.basic_publish(
    exchange='exchange_fanout_exchange',
    routing_key='',
    body=body,
)
print(" [x] Sent '%s'" % body)
connection.close()
