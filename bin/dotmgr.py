#!/usr/bin/env python3

import argparse
import json
from pathlib import Path

def get_root_of_cfg(cfg_file):
    return Path(cfg_file.name).expanduser().resolve().parent

def check(cfg_file):
    print(get_root_of_cfg(cfg_file))

def deploy(cfg_file):
    print(get_root_of_cfg(cfg_file))

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-c',  '--check', help='check' , type=open)
    parser.add_argument('-d', '--deploy', help='deploy', type=open)
    args = parser.parse_args()
    if args.check is not None:
        check(args.check)
    elif args.deploy is not None:
        deploy(args.deploy)
    else:
        parser.print_help()
