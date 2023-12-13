import subprocess
import sys


class KeyType:
    SIMPLE      = 0,
    LIST        = 1,
    SET         = 2,
    MULTILINE   = 3,
    MAP         = 4,


class GitConfig(object):
    def __init__(self, section):
        self.section = section

    def get(self, key, type=KeyType.SIMPLE, default=None):
        if type == KeyType.SIMPLE:
            cmd = '--get'
            sep = None
        if type in (KeyType.LIST, KeyType.SET):
            cmd = '--get'
            sep = ','
        elif type == KeyType.MULTILINE:
            cmd = '--get-all'
            sep = '\n'
        elif type == KeyType.MAP:
            cmd = '--get-regexp'
            sep = '\n'
        out = shell('git config {} {}.{}'.format(cmd, self.section, key))
        if not out:
            return default
        if sep is not None:
            out = out.split(sep)
            if type == KeyType.SET:
                out = set(out)
        if type != KeyType.MAP:
            return out
        d = {}
        for line in out:
            if not line:
                continue
            k, v = line.split(' ', 1)
            k = k.split('.')[-1]
            d[k] = v
        return d


def shell(cmd, capture=True, split=False):
    out = subprocess.run(cmd, capture_output=capture, shell=True, text=True)
    if capture:
        sys.stderr.write(out.stderr)
        out = out.stdout.strip('\n')
        if out and split:
            return out.split('\n')
        return out
    return out
