#!/usr/bin/env python3

import glob
import os
import shutil
import subprocess

# where all things are
DOTFILES_DIR = os.path.abspath('.')
# where all things go
HOME_DIR = os.path.expanduser('~')
# will be ignored
IGNORE = ['bootstrap.py', '.git']
# not be dotted
NO_DOT = []

VIM_VUNDLE_DIR = os.path.expanduser('~/.vim/bundle/Vundle.vim')
VIM_POWERLINE_DIR = os.path.expanduser('~/.vim/bundle/powerline')
OH_MY_ZSH_DIR = os.path.expanduser('~/.oh-my-zsh')
POWERLEVEL9K_DIR = os.path.expanduser('~/.oh-my-zsh/custom/themes/powerlevel9k')

def copytree(src, dst, symlinks=False, ignore=None):
  if not os.path.exists(dst):
    os.makedirs(dst)
  for item in os.listdir(src):
    s = os.path.join(src, item)
    d = os.path.join(dst, item)
    if os.path.isdir(s):
      copytree(s, d, symlinks, ignore)
    else:
      if not os.path.exists(d) or os.stat(s).st_mtime - os.stat(d).st_mtime > 1:
        os.symlink(s, d)


def force_remove(path):
  if os.path.isdir(path) and not os.path.islink(path):
    shutil.rmtree(path, False)
  else:
    os.unlink(path)


def git(*args):
  return subprocess.check_call(['git'] + list(args))


def install(package):
  pip.main(['install', package])


def is_link_to(link, dest):
  is_link = os.path.islink(link)
  is_link = is_link and os.readlink(link).rstrip('/') == dest.rstrip('/')
  return is_link


def config_vim():
  # if vungle does not exist yet, clone the repo
  if not os.path.isdir(VIM_VUNDLE_DIR):
    git("clone", "https://github.com/VundleVim/Vundle.vim.git", VIM_VUNDLE_DIR)
  # install powerline if not exist
  if not os.path.isdir(VIM_POWERLINE_DIR):
    git("clone", "https://github.com/Lokaltog/powerline", VIM_POWERLINE_DIR)


def config_zsh():
  # if not exist, clone oh-my-zsh git repository and powerlevel9k
  if not os.path.isdir(OH_MY_ZSH_DIR):
    git("clone", "https://github.com/robbyrussell/oh-my-zsh.git", "--depth=1", OH_MY_ZSH_DIR)
  if not os.path.isdir(POWERLEVEL9K_DIR):
    git("clone", "https://github.com/bhilburn/powerlevel9k.git", POWERLEVEL9K_DIR)


def main():
  os.chdir(os.path.expanduser(DOTFILES_DIR))
  for filename in [file for file in glob.glob('*') if file not in IGNORE]:
    dotfile = filename
    if filename not in NO_DOT:
      dotfile = '.' + dotfile
    dotfile = os.path.join(HOME_DIR, dotfile)
    source = os.path.join(DOTFILES_DIR, filename)

    # Check if is directory or file
    if os.path.isdir(source):
      copytree(source, dotfile)
    elif os.path.isfile(source):
      # Check that we aren't overwriting anything
      if os.path.lexists(dotfile):
        if is_link_to(dotfile, source):
          continue

        response = input("Overwrite file `%s'? [y/N] " % dotfile)
        if not response.lower().startswith('y'):
          print ("Skipping `%s'..." % dotfile)
          continue

        force_remove(dotfile)

      os.symlink(source, dotfile)

  # Configure zsh and powerlevel9k
  config_zsh()

  # Install vim vundle and powerline
  config_vim()


if __name__ == '__main__':
  main()