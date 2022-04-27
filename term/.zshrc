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

# Activate vim mode
bindkey -v

bindkey -v '^?' backward-delete-char
bindkey -v "^W" backward-kill-word

# Remove mode switching delay
KEYTIMEOUT=5

# Change cursor shape for different vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt
precmd() {
   echo -ne '\e[5 q'
}

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

zi load zsh-users/zsh-syntax-highlighting
zi load zsh-users/zsh-history-substring-search

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
