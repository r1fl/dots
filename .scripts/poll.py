#!/bin/python

import os, time
import argparse, json
import subprocess

"""
automatically switch monitor 
configuration on connect\disconnect
"""

TIMEOUT = 1
TIMEOUT_POST = 5 # timeout post change in layout

def main(args):
    mons = monitors()
    connected_mons = list(filter(lambda i: i[1], mons))

    conf = json.load(args.file)
    current_layout : hash = 0

    # event loop
    while True:
        layout_path = conf[str(len(connected_mons))]
        layout_path = layout_path.format(env=os.environ)

        print(f"[*] detected {layout_path}")
        with open(layout_path) as f:
            layout = json.load(f)

        layout_hash = hash(str(layout))
        if layout_hash == current_layout:
            time.sleep(TIMEOUT)
            continue

        current_layout = layout_hash
        print("[*] loading layout")
        print(layout)

        for monitor, connected in mons:
            if connected and monitor in layout:
                cmds = 'xrandr'
                for key, value in layout[monitor].items():
                    if key[0] == '_': continue
                    cmds += f' --{key} {value}'

                for flag in layout[monitor]['_flags']: 
                    cmds += f' --{flag}'

                cmd(cmds)

                for cmds in layout[monitor]['_exec']:
                    cmd(cmds.format(monitor=monitor, env=os.environ, cfg=layout[monitor]))
            else:
                cmd(f"xrandr --output {monitor} --off")

        time.sleep(TIMEOUT_POST)

def monitors() -> list:
    cmdout = cmd("xrandr -q | grep -oP '[\w\-]+ (dis)?connected'").split('\n')
    while '' in cmdout: cmdout.remove('')

    monitors = []
    for i in cmdout:
        name, status = i.split()
        monitors.append((name, (status == 'connected')))

    return monitors

def cmd(args: str):
    ps = subprocess.Popen(args + ' 2>&1', shell=True, stdout=subprocess.PIPE)
    return ps.stdout.read().decode('unicode_escape')

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('file', type=argparse.FileType('r'), help="specify the appropriate configuration file for each setup")
    main(parser.parse_args())

