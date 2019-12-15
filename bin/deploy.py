#!/usr/bin/python

import sys
import json
import pathlib
import os.path
import os
import shutil

def normalize_path(path_string):
    return pathlib.Path(os.path.expanduser(os.path.expandvars(path_string))).absolute()

def evacuate(path):
    dest = path
    count = 0
    if path.is_symlink():
        path.unlink()
    while dest.exists():
        dest = path.parent / (path.name + f'.pkg_save_{count}')
        count += 1
    if dest != path:
        shutil.move(path, dest)

def install_pkg(pkg_path):
    json_path = pkg_path / 'pkg.json' 
    with open(pkg_path / 'pkg.json', 'r') as f:
        cfg = json.loads(f.read())

        # TODO
        if 'root' in cfg and cfg['root']:
            return

        fallback = None
        if 'fallback' in cfg:
            fallback = normalize_path(cfg['fallback'])

        if 'patch' in cfg:
            patches = cfg['patch'].keys()
        else:
            patches = []

        for patch in patches:
            source = normalize_path(pkg_path / patch)
            dest   = normalize_path(cfg['patch'][patch])
            evacuate(dest)
            if cfg['link']:
                os.symlink(source, dest)
            else:
                shutil.copyfile(source, dest)
                
        if fallback is not None:
            evacuate(fallback)
            if cfg['link']:
                os.symlink(pkg_path, fallback)
            else:
                shutil.copyfile(pkg_path, fallback)

            


if __name__ == '__main__':
    cfg_path = normalize_path(sys.argv[1])
    with open(cfg_path, 'r') as f:
        cfg = json.loads(f.read())

        hooks_path = cfg_path.parent / cfg['hooks']
        pkgs_path = cfg_path.parent / cfg['pkgs']

        for pkg in pkgs_path.glob('*/'):
            install_pkg(pkg)