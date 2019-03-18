# -*- coding: utf-8 -*-
# Author: Ztj

import time
import uuid

from common import channel, pika, connection

result = channel.queue_declare(exclusive=True)
callback_queue_name = result.method.queue


def on_response(ch, method, properties, body):
    print(" [x] on_response %r" % body)


channel.basic_consume(on_response, queue=callback_queue_name, no_ack=True)

channel.basic_publish(
    exchange='',
    routing_key='rpc_queue',
    body='send',
    properties=pika.BasicProperties(
        reply_to=callback_queue_name,
        correlation_id=str(uuid.uuid4()),
    ),
)
time.sleep(3)
connection.process_data_events()
