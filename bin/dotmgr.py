#!/usr/bin/env python3

import argparse
import json

def parse_cfg(cfg):
    return json.loads(cfg.read())

def check(cfg):
    print('check')

def deploy(cfg):
    print('deploy')

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
