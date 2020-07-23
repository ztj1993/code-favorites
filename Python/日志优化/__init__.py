import json
import logging
import threading


class JsonLogger(logging.Logger):
    _glob = dict()
    _local = threading.local()

    def glob(self, k, v):
        self._glob[k] = v

    def local(self, k, v):
        self._local.__setattr__(k, v)

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

logger.glob('glob', 'bbb')

logger.info('这是一条测试日志')


def thread_1():
    logger.local('local', 'thread_1')
    logger.info('thread_1')


def thread_2():
    logger.info('thread_2')


t1 = threading.Thread(target=thread_1, args=())
t2 = threading.Thread(target=thread_2, args=())
t1.start()
t2.start()
