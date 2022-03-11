# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Source local definitions
if [ -f "${HOME}/.bashrc.local" ]; then
    source "${HOME}/.bashrc.local"
fi

# Command not found helper (works on Arch, requires pkgfile)
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
    source /usr/share/doc/pkgfile/command-not-found.bash
fi

set -o vi

# History management
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTTIMEFORMAT='%F %T '
HISTCONTROL=ignoreboth
HISTIGNORE='ll:bg:fg:history'
PROMPT_COMMAND='history -a'
shopt -s histappend
shopt -s cmdhist

# User specific aliases and functions
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ls="ls --color=auto"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -al"
alias vi="vim"
alias h="history"
alias c="clear"
alias open="xdg-open"

if command -v nvim >/dev/null 2>&1; then
    # Next-gen ultra futuristic neovim setup
    export EDITOR='nvim'
    alias vim="nvim"
else
    # Standard vim setup
    export EDITOR='vim'
fi

export BROWSER="firefox"
export TERMINAL="xterm"
export MPLAYER="cvlc"

alias fip="\$MPLAYER https://icecast.radiofrance.fr/fip-hifi.aac"
alias franceinter="\$MPLAYER https://icecast.radiofrance.fr/franceinter-hifi.aac"
alias franceinfo="\$MPLAYER https://direct.franceinfo.fr/live/franceinfo-hifi.aac"

export PATH=$HOME/.local/bin:"$PATH"

if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
    export FZF_DEFAULT_COMMAND="rg --files"
fi

function mkcd () { mkdir -p "$1" && cd "$1"; }

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
hourcolour='\[\e[1;37m\]'
reset='\[\e[0m\]'
dateformat='%R'

PS1="┌─[${usercolour}\u${atcolour}@${hostcolour}\h${atcolour}:${dircolour}\w${atcolour}]-[${hourcolour}\t${reset}]\n└> "
