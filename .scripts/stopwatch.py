#!/bin/python

from datetime import datetime
import curses, os, time

# 00:12 seconds past start
# ----------------------------
# 0: 0:06
# 1: 0:06


def main():
    cls = lambda: print('\n'*100)
    pretitime = lambda ts: time.strftime("%H:%M:%S", time.gmtime(ts))

    scr = curses.initscr()
    scr.nodelay(1)

    t0 = int(time.time())

    laps = []
    while True:
        #scr.clear()
        cls()

        t = int(time.time())
        ch = scr.getch()
        laps.append(t)

        a = '{} seconds past start'.format(pretitime(t-t0))
        print(a, end='\r\n')

        print('-'* int(len(a)*1.2), end='\r\n')

        prev = t0
        for no, lap in enumerate(laps):
            delta = lap-prev
            print('{}: {}'.format(no, pretitime(delta)), end='\r\n')
            prev = lap

        if ch == -1:
            laps = laps[:-1]
        elif ch == 112:
            input()

        time.sleep(0.01)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        os.system('reset')
        print('bye bye')
