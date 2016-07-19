#!/bin/sh



# script is intended to be run in the directory where it lives
bin=$(dirname $(readlink -e $0))
cd $bin


# all files at toplevel of this repo get symlinked from $HOME, with
# a few exclusions
git ls-tree HEAD --name-only | \
    grep -v README | grep -v .gitignore | grep -v install.sh | \
    xargs -n1 readlink -e | \
    xargs ln -s -v --backup=numbered -t $HOME
