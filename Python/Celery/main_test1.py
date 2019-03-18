# -*- coding: utf-8 -*-
# Author: Ztj

import logging
import time

from test1.celery import app
from test1.tasks import add, loop_log

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')


def now_execute():
    """现在执行"""
    print("--- Start add.apply_async((4, 4)) ---")
    print("这是一个立即执行任务")
    # 调用任务
    res = add.apply_async((4, 4))
    print("添加任务：%s" % res.id)
    # 判断任务是否完毕
    is_finish = res.ready()
    print("任务完成状态：%s" % is_finish)
    # 获取任务执行结果
    result = res.get(timeout=1)
    print("任务执行结果：%s" % result)
    print("--- End add.apply_async((4, 4)) ---")


def delay_execute():
    """延时 10s 执行"""
    print("--- Start add.apply_async((2, 2), queue='queue1', countdown=10) ---")
    print("这是一个延时 10s 任务执行")
    # 调用任务
    res = add.apply_async((2, 2), queue='queue1', countdown=10)
    print("添加任务：%s" % res.id)
    # 判断任务是否完毕
    for i in range(15):
        print("任务执行状态：%s" % res.state)
        time.sleep(1)
    # 异步获取任务执行结果
    result = app.AsyncResult(res.id)
    print("异步获取任务执行结果：%s" % result.get(timeout=1))
    print("--- End add.apply_async((2, 2), queue='queue1', countdown=10) ---")


def log_task_execute(num):
    """日志任务执行"""
    print("--- Start loop_log.delay(num) ---")
    print("这是一个日志任务执行")
    # 调用任务
    res = loop_log.delay(num)
    print("添加任务：%s" % res.id)
    # 判断任务是否完毕
    for i in range(15):
        print("任务执行状态：%s" % res.state)
        time.sleep(1)
    # 异步获取任务执行结果
    result = app.AsyncResult(res.id)
    print("异步获取任务执行结果：%s" % result.get(timeout=1))
    print("--- End loop_log.delay(num) ---")


print('-------------------------------')
# 这里进行函数调用

print('-------------------------------')
