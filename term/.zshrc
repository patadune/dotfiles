# .zshrc

# Source local definitions
if [ -f "${HOME}/.zshrc.local" ]; then
    source "${HOME}/.zshrc.local"
fi

# Source aliases
source "${HOME}/.aliases"

# Enable colors and change prompt:
autoload -U colors && colors
PS1="┌─[%B%{$fg[green]%}%n%{$reset_color%}%b@%B%{$fg[yellow]%}%M%b:%B%{$fg[blue]%}%~%b%{$reset_color%}]"$'\n'"└> "

autoload -U +X compinit && compinit

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

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
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-history-substring-search

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -a '^[[H' beginning-of-line
bindkey -a '^[[F' end-of-line

export ZVM_ESCAPE_KEYTIMEOUT=0.01
