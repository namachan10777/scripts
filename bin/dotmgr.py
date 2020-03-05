#!/usr/bin/env python3

import argparse
import json
from pathlib import Path
import os

class DotMgrError(Exception):
    pass

def normalize_path(path_string):
    return Path(os.path.expandvars(path_string)).expanduser().resolve()

def get_root_of_cfg(cfg_file_path_string):
    return normalize_path(cfg_file_path_string).parent

def parse_cfg_file(cfg_file):
    return json.loads(cfg_file.read())

def read_json(path):
    path_normalized = normalize_path(path)
    try:
        f = open(path_normalized, 'r')
        return (json.loads(f.read()), path_normalized)
        raise DotMgrError(f'File Not found {path}')
    except json.decoder.JSONDecodeError:
        raise DotMgrError(f'{path} is not a JSON')

class Pkg:
    def __init__(self, pkg_file_path):
        self.cfg, _ = read_json(pkg_file_path / 'pkg.json')

class Config:
    def __init__(self, cfg_file_path):
        self.cfg, json_path = read_json(cfg_file_path)
        self.parent = json_path.parent

    def configure_envs(self):
        for env_name in self.cfg['additional_envs'].keys():
            env = self.cfg['additional_envs'][env_name]
            value = env['value']

            if env['resolve']:
                value = str(Path(value).expanduser().resolve())

            if env_name not in os.environ or env['type'] == 'overwrite':
                os.environ[env_name] = value
            elif env['type'] == 'append':
                os.environ[env_name] = os.environ[env_name] + ':' + value

    def load_pkgs(self):
        pkgs = []
        for entry in (self.parent / self.cfg['pkgs']).glob('*'):
            pkgs.append(Pkg(entry))

def check(cfg_file_path):
    cfg = Config(cfg_file_path)
    cfg.configure_envs()
    cfg.load_pkgs()

def deploy(cfg_file_path):
    cfg = Config(cfg_file_path)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-c',  '--check', help='check' )
    parser.add_argument('-d', '--deploy', help='deploy')
    args = parser.parse_args()
    try:
        if args.check is not None:
            check(args.check)
        elif args.deploy is not None:
            deploy(args.deploy)
        else:
            parser.print_help()
    except DotMgrError as e:
        print(e)
        exit(1)
    exit(0)
