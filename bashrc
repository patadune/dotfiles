# .bashrc

export LANG="en_US.UTF-8"
export GCC_COLORS=1

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Avoid .folders to appear in tab autocomplete
bind 'set match-hidden-files off'
bind "set completion-ignore-case on"

# User specific aliases and functions
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ls='ls --color=auto'
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -al"
alias vi="vim"

export EDITOR='vim'
export BROWSER="firefox"

PATH=$HOME/.local/bin:"$PATH"
PATH=/matieres/3MM1PGL/global/bin:"$PATH"
PATH=$HOME/Projet_GL/src/main/bin:"$PATH"
PATH=$HOME/Projet_GL/src/test/script:"$PATH"
PATH=$HOME/Projet_GL/src/test/script/launchers:"$PATH"
export PATH

# Useful env variables for locally installed libraries
export LD_LIBRARY_PATH=$HOME/.local/lib:"$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig

if [ $TERM == "rxvt-unicode-256color" ]
then
    export TERM=xterm-256color
fi

function mkcd () { mkdir -p "$1" && cd "$1"; }

alias ssh-add="ssh-add ~/.ssh/re3m1.key"

# fancy prompt
linecolour='\[\e[0;37m\]'
datecolour='\[\e[1;36m\]'
if [[ $UID == 0  ]]; then
    usercolour='\[\e[1;31m\]';
else
    usercolour='\[\e[1;32m\]';
fi
hostcolour='\[\e[1;33m\]'
atcolour='\[\e[1;0m\]'
dircolour='\[\e[1;34m\]'
reset='\[\e[0m\]'
dateformat='%R'

PS1="${usercolour}\u${atcolour}@${hostcolour}\h${atcolour}:${dircolour}\w${reset}\$ "
