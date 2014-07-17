#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# based on https://github.com/michaeljsmalley/dotfiles/ installation script
# TODO : Python virtualenv installation (with virtualenvwrapper ?)
############################

########## Variables

dir=~/.dotfiles # dotfiles directory
olddir=~/.dotfiles_old # old dotfiles backup directory
files="bashrc vimrc vim zshrc gitconfig" # list of files/folders to symlink in homedir

##########

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
    if [ -L ~/.$file ]; then
        echo "> Symlink to .$file already exists."
    elif [ -f ~/.$file ]; then
        echo "> Moving old .$file from ~ to $olddir"
        mv ~/.$file ~/dotfiles_old/
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/.$file
    else
        echo "> No old .$file found."
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/.$file
    fi
done


# liquidprompt installation
if [ ! -f ~/.liquidprompt/liquidprompt ]; then
    cd
    git clone https://github.com/nojhan/liquidprompt.git
    source ~/.liquidprompt/liquidprompt
fi

install_zsh () {
# Test to see if zshell is installed. If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        echo "changing default shell to zsh"
        chsh -s $(which zsh)
        echo "done"
    fi
else
    # If zsh isn't installed, try with apt-get or yum
    # or tell the user to install zsh :)
    if [ sudo apt-get install zsh ]; then
        echo "zsh installed using apt-get"
        install_zsh
    elif [ sudo yum install zsh ]; then
        echo "zsh installed using yum"
        install_zsh
    else
        echo "Please install zsh, then re-run this script!"
    fi
fi
}

install_zsh
