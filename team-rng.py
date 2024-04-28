#!/usr/bin/env python3
import random
import subprocess


def copy2clip(txt):
    cmd = 'echo ' + txt.strip() + '| xclip -sel clip'
    return subprocess.check_call(cmd, shell=True)


def main():
    members = [
        'Tyler',
        'Kim',
        'Cameron',
        'Andy',
        'Christy'
    ]

    random.shuffle(members)

    members_str = ', '.join(members)

    try:
        copy2clip(members_str)
    except:
        pass

    print(members_str)


if __name__ == '__main__':
    main()
