# .bashrc

export GCC_COLORS=1

# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Command not found helper (works on Arch, requires pkgfile)
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
    source /usr/share/doc/pkgfile/command-not-found.bash
fi

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

if command -v mpv >/dev/null 2>&1; then
    export MEDIAPLAYER="mpv"
else
    export MEDIAPLAYER="cvlc"
fi

alias fip="\$MEDIAPLAYER http://direct.fipradio.fr/live/fip-midfi.mp3"
alias inter="\$MEDIAPLAYER http://direct.franceinter.fr/live/franceinter-midfi.mp3"

# Useful env variables for locally installed libraries
export LD_LIBRARY_PATH=$HOME/.local/lib:"$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig

export PATH=$HOME/.local/bin:$HOME/.dotfiles/bin:"$PATH"

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

cd

# Check pew presence and source config
# TODO : change that to handle virtualenvs better in prompt
command -v pew >/dev/null 2>&1 && source $(pew shell_config)

if [ ! -z "${XDG_RUNTIME_DIR}" ]; then
    # Commands to be executed before the prompt is displayed
    # Save current working dir
    PROMPT_COMMAND='pwd > "${XDG_RUNTIME_DIR}/.cwd"'

    # Change to saved working dir
    [[ -f "${XDG_RUNTIME_DIR}/.cwd" ]] && cd "$(< ${XDG_RUNTIME_DIR}/.cwd)"
fi
