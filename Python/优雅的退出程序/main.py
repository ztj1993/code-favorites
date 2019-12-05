import signal
import time


class App(object):
    is_run = True

    def __init__(self, is_listen=False):
        signal.signal(signal.SIGINT, self.exit)
        signal.signal(signal.SIGTERM, self.exit)
        is_listen and self.listen()

    def exit(self, signum, frame):
        self.is_run = False

    def listen(self):
        while self.is_run:
            print('==== start ====')
            time.sleep(10)
            print('==== end ====')


if __name__ == '__main__':
    App(is_listen=True)
