# -*- coding: utf-8 -*-
# Author: Ztj

import os
import time
from multiprocessing import Process

import psutil


class Listen(object):

    def listen(self):
        """监听"""
        for i in range(3):
            p = Process(name='Job-%s' % i, target=self.listen_callback, args=(i,))
            p.start()

    @staticmethod
    def listen_callback(i):
        """定时进程回调"""
        pps = psutil.Process(os.getppid())
        while True:
            if pps.status() in (psutil.STATUS_DEAD, psutil.STATUS_STOPPED):
                break
            print('正在执行中(%s)......' % i)
            time.sleep(1)


if __name__ == '__main__':
    listen = Listen()
    listen.listen()
