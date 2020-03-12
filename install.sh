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

# we have submodules now for vim plugins. Make sure they are up to date
git submodule update --init --recursive

export ZSH="$HOME/.oh-my-zsh"

if [[ -d "$ZSH" ]]; then
    echo "Skipping oh-my-zsh install because '$ZSH' already exists"
else

    # install oh-my-zsh first
    #   --unattended doesn't try to change the default shell or run zsh after doing the install
    (set -x ; sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended)
fi



# install spaceship prompt
ZSH_CUSTOM="$ZSH/custom"
SPACESHIP="$ZSH_CUSTOM/themes/spaceship-prompt"
if [[ -d "SPACESHIP" ]]; then
    echo "Skipping spaceship-prompt install because '$SPACESHIP' already exists"
else
    echo "Installing spaceship-prompt"
    (   set -x
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    )
fi





# all files at toplevel of this repo get symlinked from $HOME, with
# a few exclusions
git ls-tree HEAD --name-only | \
    grep -v README | grep -v install.sh | grep -v install-powerline-fonts.sh | grep -v '\.*.user' \
    xargs -n1 readlink -e | \
    xargs ln -s -v --backup=numbered -t $HOME

# prepare for other things to muck with .bashrc, .profile, .zshrc
# e.g. conda init
#
# So, all .*.user files also need to append themselves to the real dotfile
# This leaves the real files out of version control so that they can also contain
# secret crap I don't want to have in version control
git ls-tree HEAD --name-only | \
    grep -v README | grep -v install.sh | grep -v install-powerline-fonts.sh | grep '\.*.user' \
    xargs -n1 readlink -e | \
    xargs -n1 bash -vc 'echo ". $1" into "$HOME/${${1%.user}##*/"' 



# Now that we've got all of the dotfiles in place, run vim to update the Help index
# with all of the plugin submodules
vim -c "Helptags | q"


