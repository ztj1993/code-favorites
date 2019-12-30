from mqtt_base import *

mqtt_server.subscribe('$share/group/' + topic_base + '/#')

mqtt_server.loop_forever()
