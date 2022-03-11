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

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

export PATH=$HOME/.local/bin:"$PATH"

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# examples here -> https://z-shell.pages.dev/docs/gallery/collection

zi load jeffreytse/zsh-vi-mode
zi load zsh-users/zsh-syntax-highlighting
zi load zsh-users/zsh-history-substring-search

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -a '^[[H' beginning-of-line
bindkey -a '^[[F' end-of-line

export ZVM_ESCAPE_KEYTIMEOUT=0.01
