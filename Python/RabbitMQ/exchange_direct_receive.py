# -*- coding: utf-8 -*-
# Author: Ztj

from common import channel

# 定义交换机
channel.exchange_declare(exchange='exchange_direct_exchange', exchange_type='direct')

# 随机创建队列
# exclusive=True 表示建立临时队列，当 consumer(消费者) 关闭后，该队列就会被删除
result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue

# 将队列与交换器进行绑定
channel.queue_bind(exchange='exchange_direct_exchange', queue=queue_name, routing_key='info')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)


# 从队列获取信息
channel.basic_consume(callback, queue=queue_name, no_ack=True)

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
