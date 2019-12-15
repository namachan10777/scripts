#!/usr/bin/python

import sys
import json
import pathlib
import os.path
import os
import shutil
import filecmp

def normalize_path(path_string):
    return pathlib.Path(os.path.expanduser(os.path.expandvars(path_string))).absolute()

def compare_all(a, b, show_msg=False):
        a_contents = [x for x in a.glob('**/*') if x.is_file()]
        b_contents   = [x for x in b.glob('**/*') if x.is_file()]
        if len(a_contents) != len(b_contents):
            return False
        diff = [x for x in zip(a_contents, b_contents) if not filecmp.cmp(x[0], x[1])]
        if show_msg:
            for x in diff:
                print(f'{x[0]} and {x[1]} is differed')
        return len(diff) == 0

def evacuate(path):
    dest = path
    count = 0
    if path.is_symlink():
        path.unlink()
    while dest.exists() and not compare_all(path, dest):
        dest = path.parent / (path.name + f'.pkg_save_{count}')
        count += 1
    if dest != path:
        shutil.move(path, dest)


def traverse(f, pkg_path):
    json_path = pkg_path / 'pkg.json' 
    with open(pkg_path / 'pkg.json', 'r') as cfg_file:
        cfg = json.loads(cfg_file.read())

        # TODO
        if 'root' in cfg and cfg['root']:
            return

        acc = True

        if 'patch' in cfg:
            for patch in cfg['patch'].keys():
                source = normalize_path(pkg_path / patch)
                dest   = normalize_path(cfg['patch'][patch])
                acc &= f(cfg, source, dest)
                
        if 'fallback' in cfg:
            if cfg['fallback'] is not None:
                dest = normalize_path(cfg['fallback'])
                acc &= f(cfg, pkg_path, dest)

        return acc
    return False

def sync_file(cfg, source, dest):
    evacuate(dest)
    if cfg['link']:
        dest.symlink_to(source)
    else:
        if not compare_all(source, dest):
            shutil.copytree(source, dest)

    return True

def test_file(cfg, source, dest):
    if cfg['link']:
        return dest.resolve() == source
    else:
        return compare_all(source, dest, show_msg=True)
        

if __name__ == '__main__':
    cfg_path = normalize_path(sys.argv[1])
    with open(cfg_path, 'r') as f:
        cfg = json.loads(f.read())

        hooks_path = cfg_path.parent / cfg['hooks']
        pkgs_path = cfg_path.parent / cfg['pkgs']

        for pkg in pkgs_path.glob('*/'):
            traverse(sync_file, pkg)
