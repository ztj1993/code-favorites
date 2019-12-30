import random
from mqtt_base import *

i = 0

while True:
    topic = topic_base + '/' + str(random.randint(0, 9))
    payload = i
    qos = 0
    mqtt_server.publish(topic, payload, qos)
    print('publish: %s' % dict(topic=topic, payload=payload, qos=qos))
    time.sleep(1)
    i = i + 1
