# -*- coding: utf-8 -*-
# Author: Ztj

from __future__ import absolute_import, unicode_literals

import time

from env import app


@app.task
def add(x, y):
    """加法任务"""
    return x + y


@app.task
def mul(x, y):
    """乘法任务"""
    return x * y


@app.task
def loop_log(x):
    """无限循环任务"""
    from celery.utils.log import get_task_logger
    logger = get_task_logger(__name__)
    for i in range(x):
        logger.info('已经执行了 %s 秒' % i)
        time.sleep(1)
    return 'success'
