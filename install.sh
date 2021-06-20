#!/bin/bash
function ensure_link() {
    source=$1
    target=$2
    echo -n "ensure [${target}]"
    if [ -s $target ]; then
        echo " - already linked"
    elif [ -f $target ]; then
        echo " - [error] it's file not symlink"
    else
        echo " - linking ${source} to ${target}"
        ln -s ${source} ${target}
    fi


}
function ensure_directory() {
    target=$1
    echo -n "ensure directory [${target}]"
    if [ -d ${target} ]; then
        echo " - already created"
    else
        mkdir -p ${target}
        echo " - created"
    fi
}
function install() {
    host=$1
    echo "Installing .config for ${host}"
	ensure_link ~/.config/bash/bashrc ~/.bashrc
	ensure_link ~/.config/bash/profile ~/.profile
	ensure_link ~/.config/ctags/config ~/.ctags
	ensure_link ~/.config/xorg/xinitrc ~/.xinitrc 
	ensure_link ~/.config/xorg/xinitrc ~/.xsession 
    if [ $host = "legion" ]; then
        ensure_link ~/.config/xorg/Xresources.legion ~/.Xresources 
    else
        ensure_link ~/.config/xorg/Xresources ~/.Xresources 
    fi
	ensure_directory ~/.cache
	ensure_directory ~/.cache/vim/backup/
}
HOSTNAME=$(hostname) 
install $HOSTNAME
