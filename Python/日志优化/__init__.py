import json
import logging
import threading
import time


class JsonLogger(logging.Logger):
    _glob = dict()
    _local = threading.local()

    def glob(self, k, v):
        self._glob[k] = v

    def local(self, k, v):
        self._local.__setattr__(k, v)

    def get(self, k):
        if hasattr(self._local, k):
            return self._local.__getattribute__(k)
        return self._glob.get(k)

    def handle(self, record):
        for k, v in self._glob.items():
            record.__setattr__(k, v)
        for k, v in self._local.__dict__.items():
            record.__setattr__(k, v)
        super().handle(record)


class JsonFormatter(logging.Formatter):

    def formatMessage(self, record):
        record.args = list(record.args)
        record.created_fmt = self.formatTime(record, self.datefmt)
        record.thread_name = record.threadName
        record.process_name = record.processName
        record.func_name = record.funcName
        record.line_no = record.lineno
        record.level_no = record.levelno
        record.level_name = record.levelname
        record.path_name = record.pathname

        record.relativeCreated = None
        record.threadName = None
        record.msecs = None
        record.msg = None
        record.funcName = None
        record.levelno = None
        record.levelname = None
        record.processName = None
        record.pathname = None

        record = {k: v for k, v in record.__dict__.items() if v}
        return json.dumps(record, ensure_ascii=False)


handler = logging.StreamHandler()
handler.setLevel(logging.DEBUG)
handler.setFormatter(JsonFormatter())

logger = JsonLogger(__name__)
logger.addHandler(handler)

logger.glob('全局参数', '这是一个全局参数，在所有的线程中有效')
logger.info('主线程日志输出')


def thread_1():
    logger.local('局部参数', '这是一个局部的参数，只在线程一日志中有效')
    logger.info('线程一日志输出')


def thread_2():
    logger.info('线程二日志输出')


t1 = threading.Thread(target=thread_1, args=())
t2 = threading.Thread(target=thread_2, args=())
t1.start()
time.sleep(1)
t2.start()
