# -*- coding: utf-8 -*-
# Author: Ztj

from common import channel

channel.queue_declare(queue='persistent_queue')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)
    ch.basic_ack(delivery_tag=method.delivery_tag)


channel.basic_qos(prefetch_count=1)

channel.basic_consume(callback, queue='persistent_queue')

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
