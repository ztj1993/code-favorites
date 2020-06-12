# -*- coding: utf-8 -*-
# Author: Ztj

from env import app

if __name__ == '__main__':
    app.start(['celery', 'worker', '-l', 'info', '-P', 'eventlet'])
