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
    curses.noecho()
    scr.nodelay(1)

    t0 = int(time.time())

    laps = []
    while True:
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

        print('\n(p)ause (r)eset', end='\r\n')

        if ch != 10:
            laps = laps[:-1]

            if ch == ord('p'): # pause
                print("(paused)", end='\n\r')
                scr.nodelay(0)
                while True:
                    if chr(scr.getch()) == 'p':
                        break
                scr.nodelay(1)

                newt0 = int(time.time()) - (t-t0)
                t0d = newt0 - t0
                laps = list(map(lambda l: l+t0d, laps))
                t0 = newt0

            if ch == ord('r'): # reset
                return

        time.sleep(0.01)

if __name__ == '__main__':
    try:
        while True:
            main()
    except KeyboardInterrupt:
        os.system('reset')

