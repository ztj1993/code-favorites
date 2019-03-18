# -*- coding: utf-8 -*-
# Author: Ztj

import time

from common import channel, connection

channel.exchange_declare(exchange='exchange_direct_exchange', exchange_type='direct')

body = 'Hello World! - %s' % time.time()

channel.basic_publish(
    exchange='exchange_direct_exchange',
    routing_key='info',
    body=body,
)
print(" [x] Sent '%s'" % body)
connection.close()
