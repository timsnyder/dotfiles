#!/usr/bin/env bash

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

PYTHON=python
if ! type ${PYTHON} >&/dev/null && type python3 >&/dev/null; then
    PYTHON=python3
fi

pyreadlink() {
    $PYTHON -c 'import os; print(os.path.realpath("'"$1"'"))'
}



# script is intended to be run in the directory where it lives
bin=$(dirname $(pyreadlink $0))
cd $bin

# we have submodules now for vim plugins. Make sure they are up to date
git submodule update --init --recursive

if which zsh >& /dev/null; then

    export ZSH="$HOME/.oh-my-zsh"

    if [[ -d "$ZSH" ]]; then
	echo "Skipping oh-my-zsh install because '$ZSH' already exists"
    else

	# install oh-my-zsh first
        script="$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        if [[ -z "$script" ]]; then
            echo "::ERROR:: Unable to download ohmyzsh install script. Abort!"
            exit 1
        fi
  
	#   --unattended doesn't try to change the default shell or run zsh after doing the install
	(set -x ; sh -c "$script" --unattended)
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

else
    echo "Skipping zsh stuff because zsh isn't installed and it will error. You can rerun aftet installing zsh if you want to have oh-my-zsh"
fi

(
    # install a decent default font
    if [[ "$machine" == Mac ]]; then
	fontdir=~/Library/fonts
    else
	fontdir=~/.local/share/fonts
    fi

    mkdir -p $fontdir && cd $fontdir

    # create a link because I still use old crap that uses the deprecated path
    ln -s $fontdir ~/.fonts

    curl -fLo "JetBrainsMono NL Medium Nerd Font Complete.ttf" \
	https://github.com/ryanoasis/nerd-fonts/raw/85e37e754f4b68f55cd866552e927eee0a2f927a/patched-fonts/JetBrainsMono/NoLigatures/Medium/complete/JetBrains%20Mono%20NL%20Nerd%20Font%20Complete%20Mono%20Medium.ttf

    if [[ "$machine" == Linux ]]; then
      # Reset font cache on Linux
      if which fc-cache >/dev/null 2>&1 ; then
	  echo "Resetting font cache, this may take a moment..."
	  fc-cache -f "$fontdir"
      else
	  echo "Missing fc-cache. Intall fontconfig and run 'fc-cache -f $fontdir'"
      fi
    fi
)



# all files at toplevel of this repo get symlinked from $HOME, with
# a few exclusions
git ls-tree HEAD --name-only | \
    grep -v README | grep -v install.sh | grep -v install-powerline-fonts.sh | grep -v '\.*.user' |\
    xargs -I{} -n1 $PYTHON -c 'import os; print(os.path.realpath("'{}'"))' |\
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
    xargs -I{} -n1 $PYTHON -c 'import os; print(os.path.realpath("'{}'"))' | \
    xargs -n1 -x -t bash -vc 'echo ". $0" >> "$HOME/$(basename ${0%.user})"'



# Now that we've got all of the dotfiles in place, run vim to update the Help index
# with all of the plugin submodules
vim -c "Helptags | q"


