#!/usr/bin/env python3

import os
import argparse
from jinja2 import Environment, FileSystemLoader

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('input', metavar='FILE', type=str)
    args = parser.parse_args()

    env = Environment(
        loader=FileSystemLoader('.'),
    )

    template = env.get_template(args.input)
    values = {
            'uid': os.geteuid(),
            'gid': os.getegid(),
    }
    print(template.render(values))

