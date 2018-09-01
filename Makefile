vim:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	gvim -c "PlugInstall | q | q"

tmux:
	~/.tmux/plugins/tpm/bin/install_plugins

