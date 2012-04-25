install:
	rm -f ~/.bashrc
	rm -f ~/.bash_profile
	ln -s ~/.bashrc_scripts/bashrc ~/.bashrc
	ln -s ~/.bashrc_scripts/bashrc ~/.bash_profile
