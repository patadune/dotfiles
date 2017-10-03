#!/bin/bash

########## Variables

dir=~/.dotfiles # dotfiles directory
olddir=~/.dotfiles_old # old dotfiles backup directory
files="
    bash_profile
    bashrc
    config/dunstrc
    config/i3
    config/mpv/input.conf
    config/nvim
    config/redshift.conf
    conkyrc
    gitconfig
    gitignore
    inputrc
    makepkg.conf
    mutt
    ssh/config
    terminfo
    tmux.conf
    vim
    vimrc
    xinitrc
    Xresources
"

##########

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    if [ -L ~/.$file ]; then
        echo "> Symlink to .$file already exists."
    else
        echo "> .$file is not a symlink."
    fi
done
