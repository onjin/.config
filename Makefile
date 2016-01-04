install:
	if [ ! -f ~/.bashrc ]; then ln -s ~/.config/bash/bashrc ~/.bashrc; fi
	if [ ! -f ~/.profile ]; then ln -s ~/.config/bash/profile ~/.profile; fi
	if [ ! -f ~/.ctags ]; then ln -s ~/.config/ctags/config ~/.ctags; fi
	if [ ! -f ~/.xinitrc ]; then ln -s ~/.config/xorg/xinitrc ~/.xinitrc ; fi
	mkdir -p ~/.cache
