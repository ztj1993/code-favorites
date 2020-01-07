# -*- coding: utf-8 -*-
# Intro: 单文件服务管理模块
# Author: Ztj
# Email: ztj1993@gmail.com
# Version: 0.0.1
# Date: 2020-01-07

"""
Usage:
  {self} [options]

Options:
  --help              显示帮助
  --version           显示版本
  --verbose           更多展示
  --debug             调试模式
  --id=<id>           服务编号 [default: dev]
"""

import sys
import logging.config
import verboselogs
import signal

from dynaconf import settings
from docopt import docopt

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')


class Service(object):
    NAME = None
    VERSION = None
    DESCRIPTION = None

    def __init__(self):
        arguments = docopt(__doc__, version=self.VERSION)
        self.id = arguments.get('--id')
        self.name = self.NAME
        self.version = self.VERSION
        self.description = self.DESCRIPTION
        self.debug = arguments.get('--debug')
        self.verbose = arguments.get('--verbose')
        self.logger = verboselogs.VerboseLogger(__name__)

        settings.set('service.id', self.id)
        settings.set('service.version', self.VERSION)
        settings.set('service.description', self.DESCRIPTION)
        settings.set('debug.active', self.debug)
        settings.set('debug.verbose', self.verbose)

        signal.signal(signal.SIGINT, self.stop)
        signal.signal(signal.SIGTERM, self.stop)

        self.logger.level = logging.INFO
        self.logger.level = verboselogs.VERBOSE if self.verbose else self.logger.level
        self.logger.level = logging.DEBUG if self.debug else self.logger.level

    def exec(self):
        try:
            self.start()
            self.stop()
        except KeyboardInterrupt:
            self.stop()
            sys.exit()

    def start(self):
        self.logger.info('服务启动 %s %s %s %s' % (self.name, self.version, self.id, self.description))

    def stop(self):
        self.logger.info('服务停止 %s %s %s %s' % (self.name, self.version, self.id, self.description))


if __name__ == '__main__':
    Service().exec()
