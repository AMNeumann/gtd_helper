#!/usr/bin/env python3

import subprocess
import argparse
import json

def add_entry(start, stop, tags):
    subprocess.run(['timew', 'track', start, '-', stop, *tags], check=True)

def start_entry(start, tags):
    subprocess.run(['timew', 'start', start, *tags], check=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Restore timewarrior records from export");
    parser.add_argument('input_file', metavar='FILE', type=str, help='Input file')

    args = parser.parse_args()

    with open(args.input_file) as ifp:
        json = json.loads(ifp.read())
        for entry in json:
            if 'end' in entry:
                add_entry(entry['start'], entry['end'], entry['tags'])
            else:
                start_entry(entry['start'], entry['tags'])
