# -*- coding: utf-8 -*-
# Author: Ztj

from common import channel

channel.queue_declare(queue='hello_queue')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)


channel.basic_consume(callback, queue='hello_queue', no_ack=True)

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
