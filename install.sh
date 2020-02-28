#!/bin/sh

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

case "${machine}" in
    Linux)
	;;
    Mac)
	# use readlink from homebrew build of gnu coreutils
	gnubin="/usr/local/opt/coreutils/libexec/gnubin"
	if [[ ! -d "$gnubin" ]]; then
	    echo "Error: can't find directory '$gnubin'"
	    echo "       install https://formulae.brew.sh/formula/coreutils"
	    echo "       before trying to setup your homedir"
	    exit 1
	fi

	PATH="${gnubin}:$PATH"

	;;
esac


# script is intended to be run in the directory where it lives
bin=$(dirname $(readlink -e $0))
cd $bin


# all files at toplevel of this repo get symlinked from $HOME, with
# a few exclusions
git ls-tree HEAD --name-only | \
    grep -v README | grep -v .gitignore | grep -v install.sh | \
    xargs -n1 readlink -e | \
    xargs ln -s -v --backup=numbered -t $HOME
