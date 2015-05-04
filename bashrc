# .bashrc

export LANG="en_US.UTF-8"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Avoid .folders to appear in tab autocomplete
bind 'set match-hidden-files off'

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# User specific aliases and functions
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ls='ls --color=auto'
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -al"
alias vi="vim"
alias ne="vim"
alias n="vim"

export EDITOR='vim'
export BROWSER="firefox"
export PATH="~/.local/bin:$PATH"

function mkcd () { mkdir -p "$1" && cd "$1"; }

source ~/.dotfiles/liquidprompt/liquidprompt
