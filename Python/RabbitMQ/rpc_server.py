# -*- coding: utf-8 -*-
# Author: Ztj

from common import channel, pika

channel.queue_declare(queue='rpc_queue')


def on_request(ch, method, props, body):
    print(" [x] body - %r" % body)
    response = 'reply'
    ch.basic_publish(
        exchange='',
        routing_key=props.reply_to,
        properties=pika.BasicProperties(correlation_id=props.correlation_id),
        body=response
    )
    ch.basic_ack(delivery_tag=method.delivery_tag)


channel.basic_qos(prefetch_count=1)
channel.basic_consume(on_request, queue='rpc_queue')

print(" [x] Awaiting RPC requests")
channel.start_consuming()
