#!/usr/bin/env python3

import argparse
import json
from pathlib import Path
import os

def get_root_of_cfg(cfg_file):
    return Path(cfg_file.name).expanduser().resolve().parent

def parse_cfg_file(cfg_file):
    return json.loads(cfg_file.read())

def configure_envs(cfg):
    for env_name in cfg['additional_envs'].keys():
        env = cfg['additional_envs'][env_name]
        value = env['value']

        if env['resolve']:
            value = str(Path(value).expanduser().resolve())

        if env_name not in os.environ or env['type'] == 'overwrite':
            os.environ[env_name] = value
        elif env['type'] == 'append':
            os.environ[env_name] = os.environ[env_name] + ':' + value


def check(cfg_file):
    configure_envs(parse_cfg_file(cfg_file))
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
