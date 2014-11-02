# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# User specific aliases and functions
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -al"
alias vi="vim"

export EDITOR='vim'

function mkcd () { mkdir -p "$1" && cd "$1"; }

alias pyserve='google-chrome http://localhost:8000/ && python -m SimpleHTTPServer'

# Python stuff

#export PIP_DOWNLOAD_CACHE='~/.pip/cache'

# Virtualenv Wrapper

# export WORKON_HOME=~/.virtualenvs
# export PROJECT_HOME=~/python
# mkdir -p $WORKON_HOME
# source ~/.local/bin/virtualenvwrapper.sh

source ~/.dotfiles/liquidprompt/liquidprompt
