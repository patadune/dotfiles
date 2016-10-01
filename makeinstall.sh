#!/bin/bash
############################
# makeinstall.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# based on https://github.com/michaeljsmalley/dotfiles/ installation script
############################

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
    config/termite
    conkyrc
    dircolors
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

# Fetch submodules (vundle)
cd $dir
echo "Fetching dependencies..."
git submodule init
git submodule update

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ... "
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    confdir=`dirname $file`
    if [ ! -d ~/.$confdir ]; then
        echo "Creating .$confdir before symlinking..."
        mkdir -p ~/.$confdir
    fi

    if [ -L ~/.$file ]; then
        echo "> Symlink to .$file already exists."
    elif [ -f ~/.$file ]; then
        echo "> Moving old .$file from ~ to $olddir"
        mv ~/.$file $olddir
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/.$file
    else
        echo "> No old .$file found."
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/.$file
    fi
done
