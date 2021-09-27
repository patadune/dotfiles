# .zshrc

# Source local definitions
if [ -f "${HOME}/.zshrc.local" ]; then
    source "${HOME}/.zshrc.local"
fi

alias ls="ls -G"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -al"
alias vi="vim"
alias h="history"
alias c="clear"

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

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

if command -v mpv >/dev/null 2>&1; then
    export MEDIAPLAYER="mpv"
else
    export MEDIAPLAYER="cvlc"
fi

alias fip="\$MEDIAPLAYER http://direct.fipradio.fr/live/fip-midfi.mp3"
alias inter="\$MEDIAPLAYER http://direct.franceinter.fr/live/franceinter-midfi.mp3"

export PATH=$HOME/.local/bin:"$PATH"

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit load jeffreytse/zsh-vi-mode
zinit load zsh-users/zsh-history-substring-search

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
