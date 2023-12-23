import json
import os
import re
import subprocess
import sys


def shell(cmd, capture=True, split=False):
    out = subprocess.run(cmd, capture_output=capture, shell=True, text=True)
    if capture:
        sys.stderr.write(out.stderr)
        out = out.stdout.strip('\n')
        if out and split:
            return out.split('\n')
        return out
    return out

def backports(range):
    """Return the original commit hashes backported from a git range."""
    res = []
    log = shell('git rev-list --pretty="format:%b" {}'.format(range))
    for r in BACKPORT_RE:
        res.extend(re.findall(r, log))
    return res

def changeset(commit, refresh=False, quiet=False, split=True):
    """Return the GitHub PR belonging to the given commit hash."""

    # Set variables
    out = []
    if len(commit) < SHA1_LEN:
        commit = shell('git rev-parse {}'.format(commit))
    commit_dir = '{}/changeset/commits/{}'.format(GIT_DIR, commit[:2])
    commit_path = '{}/{}'.format(commit_dir, commit[2:])
    url = 'https://github.com/rpm-software-management/rpm/pull/{}'
    if os.path.islink(commit_path):
        data_path = os.path.abspath(
            os.path.join(commit_dir, os.readlink(commit_path)))
    else:
        data_path = commit_path

    # Fetch and cache entry if needed
    if refresh or not os.path.exists(data_path):
        # Fetch data
        if not quiet:
            sys.stderr.write(
                'Fetching changeset for commit {}\n'.format(commit))
        data = shell('gh pr list --state merged --limit 1 --json '
                     'number,title,url,labels --search {}'.format(commit))
        data = json.loads(data)
        os.makedirs(commit_dir, exist_ok=True)
        if not data:
            with open(commit_path, 'w') as f:
                f.write('')
            sys.exit(1)
        assert len(data) >= 1
        data = data[0]

        # Create entry
        number = data['number']
        title = data['title']
        labels = sorted(x['name'] for x in data['labels'])
        if 'release' in labels:
            entry = ''
        else:
            entry = '{}\n{}'.format(title, ' '.join(labels))
        number_dir = '{}/changeset/numbers'.format(GIT_DIR)
        number_path = '{}/{}'.format(number_dir, number)

        # Write entry to cache
        os.makedirs(number_dir, exist_ok=True)
        with open(number_path, 'w') as f:
            f.write(entry)
        if os.path.exists(commit_path):
            os.unlink(commit_path)
        os.symlink('../../numbers/{}'.format(number), commit_path)

    # Return entry if cached
    if os.path.islink(commit_path):
        number = os.path.basename(os.readlink(commit_path))
        with open(commit_path) as f:
            entry = list(map(str.strip, f.readlines()))
        if not entry:
            sys.exit(1)
        out.append('PR #{}: {}'.format(number, entry[0]))
        if len(entry) == 2:
            out.append(entry[1])
        else:
            out.append('')
        out.append(url.format(number))

    if not split:
        out = '\n'.join(out)

    return out


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


GIT_DIR = shell('git rev-parse --path-format=absolute --git-common-dir')
CONFIG = GitConfig('cherryPlan')
BACKPORT_RE = ['^\\(cherry picked from commit (.*)\\)$'] + \
              CONFIG.get('backportPatterns', KeyType.MULTILINE, [])
BACKPORT_RE = [re.compile(r, re.MULTILINE) for r in BACKPORT_RE]
SHA1_LEN = 40
