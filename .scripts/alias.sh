# General Shell Aliases

# {{{ config file aliases
alias config='/usr/bin/git --git-dir=$HOME/git_repos/mydotfiles --work-tree=$HOME'
alias cfg-awesome="vim ~/.config/awesome/rc.lua"
alias cfg-muttrc="vim ~/.muttrc"
alias cfg-nvim="vim ~/.config/nvim/init.vim"
alias cfg-taskrc="vim ~/.taskrc"
alias cfg-tmuxconf="vim ~/.tmux.conf"
alias cfg-vimrc="vim ~/.config/nvim/.vimrc"
alias cfg-vitrc="vim ~/.vitrc"
alias cfg-zshrc="vim ~/.zshrc"
alias config='/usr/bin/git --git-dir=$HOME/git_repos/mydotfiles --work-tree=$HOME'
alias priv_config='/usr/bin/git --git-dir=$HOME/git_repos/private_dots --work-tree=$HOME'
# }}} config file aliases
# {{{ Program Aliases
alias c="cmus"
alias ve="emacs --no-window-system -q -l ~/.emacs.d/vanilla/init.el"
alias e="emacs --no-window-system -q -l ~/.emacs.d/main/init.el"
alias emacs='emacs -q -l ~/.emacs.d/main/init.el'
alias spacemacs='emacs -q -l ~/.emacs.d/spacemacs/init.el'
alias ipy="ipython"
#alias ls="lsd" # or use ls --color
alias ls="ls --color"
alias m="mutt"
alias n="nvim"
alias o="okular"
alias r="ranger"
alias rb="base16-manager set-random"
alias t="tmux"
alias v="vim --cmd 'let g:elite_mode=1'"
alias vv="vim --cmd 'let g:Vanilla=1'"
alias vd="vim --cmd 'let g:DefaultVim=1'"
alias q="exit"
alias z="zathura"
alias rr="bash ~/.scripts/rr.sh"
# }}} Program Aliases
#  {{{ Utility Aliases
alias cl="clear; ls"
#  }}} Utility Aliases
# {{{ Vim modelines
# vim: set foldmethod=marker
# }}} Vim modelines
