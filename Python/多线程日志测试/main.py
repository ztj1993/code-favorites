# -*- coding: utf-8 -*-
# Author: Ztj

import logging.config
import threading

import yaml

log_options = yaml.load(open('log.yaml', 'r').read())
logging.config.dictConfig(log_options)

logger = logging.getLogger(__name__)


class Listen(object):

    def log_listen(self):
        """日志监听"""
        for i in range(100):
            p = threading.Thread(target=self.log_callback, args=(i,))
            p.start()

    @staticmethod
    def log_callback(i):
        """日志回调"""
        for j in range(10000):
            logger.info('线程编号=%s, 日志编号=%s' % (i, j))


if __name__ == '__main__':
    Listen().log_listen()
