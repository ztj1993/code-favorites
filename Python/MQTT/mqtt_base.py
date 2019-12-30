import paho.mqtt.client as mqtt
import time

mqtt_server = mqtt.Client(protocol=mqtt.MQTTv5)
mqtt_server.username_pw_set(None, None)
mqtt_server.connect('test.mosquitto.org')


def mqtt_on_message(client: mqtt, user_data, msg: mqtt.MQTTMessage):
    try:
        print('mqtt_on_message: %s' % dict(topic=msg.topic, payload=msg.payload))
    except:
        print('mqtt_on_message error')


def mqtt_on_disconnect(client: mqtt, user_data, rc):
    print('mqtt_on_disconnect')


def mqtt_on_connect(client: mqtt, user_data, flags, rc):
    print('mqtt_on_connect')


mqtt_server.on_message = mqtt_on_message
mqtt_server.on_connect = mqtt_on_connect
mqtt_server.on_disconnect = mqtt_on_disconnect

topic_base = 'ztj/test/topic'

if __name__ == '__main__':
    mqtt_server.loop_start()
    time.sleep(2)
    mqtt_server.subscribe(topic_base)
    time.sleep(2)
    mqtt_server.publish(topic_base, 1)
    time.sleep(2)
