# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

set -o vi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -AhlF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export VISUAL=vim
export EDITOR='vim'

export PATH=~/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
alias eb-env="source ~/VirtualEnv/eb_cli_env/bin/activate"

#ISCE
export ISCE_HOME=/usr/local/isce
export PATH=$PATH:$ISCE_HOME/bin:$ISCE_HOME/applications
export PYTHONPATH=$PYTHONPATH:/usr/local

#GDAL
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal

export SCONS_CONFIG_DIR=/home/william/isce_requirements

DIR_CMD='pushd'
TSP_REPO='~/repositories/hyp3-time-series'
SEMESTER='~/repositories/classes/spring-2018'

function aenv {
    source ~/envs/$1/bin/activate
}

function mkenv {
    python2 ~/envs/$1
}

function mkenv3 {
    python3 -m venv ~/envs3/$1
}

function aenv3 {
    source ~/envs3/$1/bin/activate
}



alias weka='java -jar ~/Programs/weka-3-8-1/weka.jar'

alias trm='tmux kill-session -t '
alias tls='tmux ls'
alias ta='tmux a -t '

function tn {
    SESSION=$1
    tmux new-session -d -s $SESSION

    tmux new-window -t $SESSION
    tmux new-window -t $SESSION
    tmux new-window -t $SESSION
    tmux attach-session -t $SESSION
    tmux select-pane -R
}

alias classes='eval $DIR_CMD $SEMESTER'
alias construction='eval $DIR_CMD $SEMESTER/construction'
alias architecture='eval $DIR_CMD $SEMESTER/architecture'
alias langs='eval $DIR_CMD $SEMESTER/langs'
alias rendering='eval $DIR_CMD $SEMESTER/rendering'
alias ai='eval $DIR_CMD $SEMESTER/ai'

alias tsp='eval $DIR_CMD $TSP_REPO'
alias tspl='eval $DIR_CMD $TSP_REPO/Lambdas'
alias tspc='eval $DIR_CMD $TSP_REPO/Containers'

alias water-monitor='python ~/Programs/water-monitor/monitor.py'

alias tspcb='eval $DIR_CMD $TSP_REPO/Containers/Bundler'
alias tspcgi='eval $DIR_CMD $TSP_REPO/Containers/Giant'
alias tspcga='eval $DIR_CMD $TSP_REPO/Containers/Gamma'
alias tspci='eval $DIR_CMD $TSP_REPO/Containers/Isce'
alias tspi='eval $DIR_CMD $TSP_REPO/Interface'

API_REPO='$HOME/repositories/hyp3-api'
alias api='eval $DIR_CMD $API_REPO'
alias apif='eval $DIR_CMD $API_REPO/hyp3-flask'
alias apia='eval $DIR_CMD $API_REPO/hyp3-api'

alias terminator='python3 $TSP_REPO/Lambdas/Delegator/utils/terminator.py'
alias catch='curl -L https://github.com/philsquared/Catch/releases/download/v1.10.0/catch.hpp > catch.hpp'

alias empty-trash='sudo rm -rf /home/william/.local/share/Trash/files/*'
alias start-last-container='docker start  `docker ps -q -l` && docker attach `docker ps -q -l`'
alias safes='eval $DIR_CMD $HOME/time-series-data/granule_safes'
alias call='git add . && git commit'

alias untar='tar -xvf'

alias interface-env="source ~/VirtualEnv/time-series-interface/bin/activate"

alias python=python3
alias pserver='python3 -m http.server'
alias vim='/home/wbhorn/Programs/squashfs-root/usr/bin/nvim'
alias nvim='/home/wbhorn/Programs/squashfs-root/usr/bin/nvim'

alias snipper-tool='shutter'
alias logisim='java -jar ~/Programs/logisim-generic-2.7.1.jar &'
alias glslang='~/Programs/glslang/bin/glslangValidator'

alias prune="sudo docker system prune"
alias x="xdg-open"
# This is for vimtex to work

alias large-files='sudo du -h / | grep -E "[0-9]G"'
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

function cd {
    builtin cd "$@" && ls -F
}

function pushd {
    builtin pushd "$@" && ls -F
}

export GITHUB="https://www.github.com"
export MY_GITHUB="https://www.github.com/williamh890"

export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=/usr/bin:$PATH

export DOCKER_HOST=unix:///run/user/1000/docker.sock
nvm use 20

alias team-rng='~/Programs/team-rng.py'
