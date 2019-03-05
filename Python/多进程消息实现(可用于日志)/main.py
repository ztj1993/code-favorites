# -*- coding: utf-8 -*-
# Author: Ztj

import logging.config
import os
import threading
import time
from concurrent.futures import ThreadPoolExecutor
from ctypes import c_bool
from multiprocessing import Process, Value, Queue

import yaml

log_options = yaml.load(open('log.yaml', 'r').read())
logging.config.dictConfig(log_options)

logger = logging.getLogger(__name__)


class Listen(object):
    is_run = True

    def __init__(self):
        self.queue = Queue()

    def log_listen(self):
        """日志监听"""
        p = threading.Thread(target=self.log_callback, args=(self.queue,))
        p.start()

    def log_callback(self, queue):
        """日志回调"""
        while not queue.empty() or self.is_run:
            for i in range(queue.qsize()):
                logger.info(queue.get())

    def cron_listen(self, ):
        """定时监听"""
        t = threading.Thread(target=self.cron_thread_callback, args=(self.queue,))
        t.start()

    def cron_thread_callback(self, queue):
        """定时线程回调"""
        last_second = 0
        is_run = Value(c_bool, self.is_run)
        while self.is_run:
            cur_time = str(int(time.time()))
            if not last_second == cur_time:
                t = threading.Thread(target=self.cron_thread_process_callback, args=(queue, cur_time,))
                t.start()
            last_second = cur_time
            time.sleep(0.4)
        is_run.value = self.is_run

    def cron_thread_process_callback(self, queue, cur_time):
        """定时线程进程回调"""
        print('开始执行：%s' % cur_time)
        p = Process(name='Job-' + cur_time, target=self.cron_process_callback, args=(queue, cur_time,))
        p.start()

    def cron_process_callback(self, queue, cur_time):
        """定时进程回调"""
        i = 0
        pool = ThreadPoolExecutor(5)
        while i < 100000:
            i = i + 1
            pool.submit(self.cron_callback, queue, cur_time, i)
        pool.shutdown()

    @staticmethod
    def cron_callback(queue, cur_time, i):
        """定时回调"""
        queue.put({
            'cur_time': cur_time,
            'i': i
        })


if __name__ == '__main__':
    listen = Listen()
    listen.is_run = True
    listen.log_listen()
    listen.cron_listen()
    time.sleep(3)
    listen.is_run = False
