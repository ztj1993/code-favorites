# -*- coding: utf-8 -*-
# Author: Ztj

from __future__ import absolute_import, unicode_literals

from celery import Celery

app = Celery('app',
             broker='redis://192.168.120.116:6379/3',
             backend='redis://192.168.120.116:6379/4',
             include=['tasks'])

app.conf.update(
    result_expires=3600,
    timezone='Asia/Shanghai',
)
