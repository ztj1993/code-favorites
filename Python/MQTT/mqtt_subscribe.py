from mqtt_base import *

mqtt_server.subscribe(topic_base + '/#')

mqtt_server.loop_forever()
