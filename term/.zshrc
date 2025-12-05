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
setopt INC_APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS

export PATH=$HOME/.local/bin:"$PATH"

# Activate vi mode
bindkey -v

# Override vi-compatible behavior
bindkey -M viins "^?" backward-delete-char
bindkey -M viins "^W" backward-kill-word

# Enable prefix search with arrow keys
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

# When in doubt, revert to the real deal
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Initialize completion
autoload -U compinit; compinit

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

if command -v fzf >/dev/null 2>&1; then
  # Set up fzf key bindings and fuzzy completion
  source <(fzf --zsh)
fi
