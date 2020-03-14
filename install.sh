#!/bin/sh

set -o pipefail
set -e

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

pyreadlink() {
    python -c 'import os; print(os.path.realpath("'"$1"'"))'
}



# script is intended to be run in the directory where it lives
bin=$(dirname $(pyreadlink $0))
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
if [[ -d "$SPACESHIP" ]]; then
    echo "Skipping spaceship-prompt install because '$SPACESHIP' already exists"
else
    echo "Installing spaceship-prompt"
    (   set -x
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$SPACESHIP"
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$SPACESHIP"
    )
fi


ZSH_AUTO="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
if [[ -d "$ZSH_AUTO" ]]; then
    echo "Skipping zsh-autosuggestions install because '$ZSH_AUTO' already exists"
else
    echo "Installing zsh-autosuggestions"
    (   set -x
	git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_AUTO"
    )
fi

ZSH_HISTDB="$ZSH_CUSTOM/plugins/zsh-histdb"
if [[ -d "$ZSH_HISTDB" ]]; then
    echo "Skipping zsh-histdb install because '$ZSH_HISTDB' already exists"
else
    echo "Installing zsh-histdb"
    (   set -x
	git clone https://github.com/larkery/zsh-histdb "$ZSH_HISTDB"
    )
fi




# all files at toplevel of this repo get symlinked from $HOME, with
# a few exclusions
git ls-tree HEAD --name-only | \
    grep -v README | grep -v install.sh | grep -v install-powerline-fonts.sh | grep -v '\.*.user' |\
    xargs -I{} -n1 python -c 'import os; print(os.path.realpath("'{}'"))' |\
    xargs -n1 -x -t -I{} ln -s -v --backup=numbered {} $HOME

# prepare for other things to muck with .bashrc, .profile, .zshrc
# e.g. conda init
#
# So, all .*.user files also need to append themselves to the real dotfile
# This leaves the real files out of version control so that they can also contain
# secret crap I don't want to have in version control


# TODO this ends up still adding crap after I've done it the first time if I rerun install.sh
git ls-tree HEAD --name-only | \
    grep -v README | grep -v install.sh | grep -v install-powerline-fonts.sh | grep '\.*.user' |\
    xargs -I{} -n1 python -c 'import os; print(os.path.realpath("'{}'"))' | \
    xargs -n1 -x -t bash -vc 'echo ". $0" >> "$HOME/$(basename ${0%.user})"'



# Now that we've got all of the dotfiles in place, run vim to update the Help index
# with all of the plugin submodules
vim -c "Helptags | q"


