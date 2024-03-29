# Stuff that can be shared amongst SH dialect shells


unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

unset unameOut

if [ -d "${HOME}/bin" ]; then
    export PATH=$PATH:"$HOME/bin"
fi

case "${machine}" in
    Linux) 
	;;
    Mac)
	# the Catalina vim has a bug where ':set diffopt+=iwhite' results in a nonsensical error
	# put macvim early in path to override the default vim
	export PATH=/Applications/MacVim.app/Contents/bin:$PATH

	# put vncviewer app on the path
	export PATH="$PATH:/Applications/VNC Viewer.app/Contents/MacOS"

	# put yEd app on the path
	export PATH="$PATH:/Applications/yEd.app/Contents/MacOS"
	alias yed=yEd

	;;
esac

export EDITOR=vim

#eval "$(dircolors -b)"
# mac OSX doesn't have dircolors from gnu coreutils. If you install homebrew coreutils, you can get
# gdircolors, I'm just hardcoding the output of it in here to avoid the goofiness and having to
# depend on dircolors being installed.
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

case "${machine}" in
    Linux) 
	export LS_FLAGS=' --color=auto'
	;;
    Mac)
	export CLICOLOR=1 
	# Used gnu2bsd from https://github.com/lucas-flowers/gnu2bsd to translate LS_COLORS to LSCOLORS
	export LSCOLORS='ExGxFxdaCxDaDahbadacec'
	;;
esac

gt ()
{
    # cd to root of current git repo
    top=$(git rev-parse --show-toplevel)
    if [[ -d "$top" ]]; then
	cmd="cd $top"
	if set -o | grep '^xtrace[[:space:]]\+off' 2>&1 >/dev/null; then
	    echo "+ $cmd"
	fi
	eval "$cmd"
    else
	echo "can't cd to non-existant directory:'$top'"
	return 1
    fi
}

gtt ()
{
    # cd to root of topmost git superproject
    gt
    while [[ "$(git -C .. rev-parse --is-inside-work-tree 2>/dev/null)" == true ]]; do
	cd ..
	gt
    done
}

git-owner ()
{
    if [[ ! -f ~/github_token ]]; then
	echo "::ERROR:: Please put a personal access token in ~/github_token"
    fi
    curl -H "Authorization: token $(cat ~/github_token)" https://api.github.com/repos/$1/collaborators  | jq '[ .[] | select(.permissions.admin == true) | .login ]'
}

docker.socat() {
   # use on macos to connect the docker display to XQuartz
   socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
}


# set spaceship_prompt to differentiate virtualenv environments
SPACESHIP_VENV_SYMBOL="ⓥ "

# configure my git status timeout to 1s
SPACESHIP_GIT_STATUS_TIMEOUT_DELAY="1s"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# make zstd use level 9 by default instead of it's builtin 3
export ZSTD_CLEVEL=9

conda.bootstrap () {
    if [[ $# -ne 1 ]]; then
	echo "Usage: conda.bootstrap <miniconda install path>"
	return 1
    fi
    __conda_prefix="$1"
    if [[ ! -e "$__conda_prefix/bin/conda" ]]; then
	echo "::ERROR:: '$__conda_prefix' is not a conda install. ('$__conda_prefix/bin/conda doesn't exist)"
	return 1
    fi
    __conda_setup="$("$__conda_prefix/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
	eval "$__conda_setup"
    else
	if [ -f "$__conda_prefix/etc/profile.d/conda.sh" ]; then
	    . "$__conda_prefix/etc/profile.d/conda.sh"
	else
	    export PATH="$__conda_prefix/bin:$PATH"
	fi
    fi
    unset __conda_setup
    unset __conda_prefix
}

conda.mine() {
    if [[ -d "$HOME/miniforge3" ]]; then
	conda.bootstrap "$HOME/miniforge3"
    elif [[ -d "$HOME/miniconda3" ]]; then
	conda.bootstrap "$HOME/miniconda3"
    elif [[ -d "$HOME/opt/miniconda3" ]]; then
	conda.bootstrap "$HOME/opt/miniconda3"
    fi
}

log.date() {
    # call date how log-stats does it
    # Nanoseconds truncated to 6 digits because Python can only parse up to
    # microseconds
    date --utc +%Y-%m-%dT%H:%M:%S.%6N%z
}
