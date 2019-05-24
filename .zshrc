# {{{ Header
# Author: Jordan Schupbach
# Date: September 1, 2018
# Purpose: September 1, 2018
# }}} Header


# {{{ ENV
HISTFILE=$HOME/.zsh_history
APPEND_HISTORY=TRUE
# }}} ENV
# {{{ Load zplug
ZPLUG_HOME=$HOME/git_repos/zplug
source $ZPLUG_HOME/init.zsh
# }}} Load zplug
# {{{ zplug examples
# # Make sure to use double quotes
# zplug "zsh-users/zsh-history-substring-search"
#
# # Use the package as a command
# # And accept glob patterns (e.g., brace, wildcard, ...)
# zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"
#
# # Can manage everything e.g., other person's zshrc
# zplug "tcnksm/docker-alias", use:zshrc
#
# # Disable updates using the "frozen" tag
# zplug "k4rthik/git-cal", as:command, frozen:1
#
# # Grab binaries from GitHub Releases
# # and rename with the "rename-to:" tag
# zplug "junegunn/fzf-bin", \
#     from:gh-r, \
#     as:command, \
#     rename-to:fzf, \
#     use:"*darwin*amd64*"
#
# # Supports oh-my-zsh plugins and the like
# zplug "plugins/git",   from:oh-my-zsh
#
# # Also prezto
# zplug "modules/prompt", from:prezto
#
# # Load if "if" tag returns true
# zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
#
# # Run a command after a plugin is installed/updated
# # Provided, it requires to set the variable like the following:
# # ZPLUG_SUDO_PASSWORD="********"
# zplug "jhawthorn/fzy", \
#     as:command, \
#     rename-to:fzy, \
#     hook-build:"make && sudo make install"
#
# # Supports checking out a specific branch/tag/commit
# zplug "b4b4r07/enhancd", at:v1
# zplug "mollifier/anyframe", at:4c23cb60
#
# # Can manage gist file just like other packages
# zplug "b4b4r07/79ee61f7c140c63d2786", \
#     from:gist, \
#     as:command, \
#     use:get_last_pane_path.sh
#
# # Support bitbucket
# zplug "b4b4r07/hello_bitbucket", \
#     from:bitbucket, \
#     as:command, \
#     use:"*.sh"
#
# # Rename a command with the string captured with `use` tag
# zplug "b4b4r07/httpstat", \
#     as:command, \
#     use:'(*).sh', \
#     rename-to:'$1'
#
# # Group dependencies
# # Load "emoji-cli" if "jq" is installed in this example
# zplug "stedolan/jq", \
#     from:gh-r, \
#     as:command, \
#     rename-to:jq
# zplug "b4b4r07/emoji-cli", \
#     on:"stedolan/jq"
# # Note: To specify the order in which packages should be loaded, use the defer
# #       tag described in the next section
#
# # Set the priority when loading
# # e.g., zsh-syntax-highlighting must be loaded
# # after executing compinit command and sourcing other plugins
# # (If the defer tag is given 2 or above, run after compinit command)
# zplug "zsh-users/zsh-syntax-highlighting", defer:2
#
# # Can manage local plugins
# zplug "~/.zsh", from:local
#
# # Load theme file
# zplug 'dracula/zsh', as:theme
#
#
# }}} zplug examples
# {{{ zplug plugins

# {{{ oh-my-zsh plugins

zplug "plugins/archlinux",   from:oh-my-zsh #Only need on archlinux machines
zplug "plugins/colored-man-pages",   from:oh-my-zsh
zplug "plugins/colorize",   from:oh-my-zsh
#zplug "plugins/dirhistory",   from:oh-my-zsh
zplug "plugins/extract",   from:oh-my-zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/pip",   from:oh-my-zsh
zplug "plugins/reminder",   from:oh-my-zsh
zplug "plugins/taskwarrior",   from:oh-my-zsh
zplug "plugins/tig",   from:oh-my-zsh
zplug "plugins/tmux",   from:oh-my-zsh
zplug "plugins/tmuxinator",   from:oh-my-zsh
zplug "plugins/vi-mode",   from:oh-my-zsh
zplug "plugins/wd",   from:oh-my-zsh
zplug "plugins/z",   from:oh-my-zsh
zplug "plugins/zsh-navigation-tools",   from:oh-my-zsh

# }}} oh-my-zsh plugins
# {{{ github

zplug "hchbaw/zce.zsh"
zplug "1ambda/zsh-snippets"
zplug "zsh-users/fizsh"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zaw"
#zplug "vifon/deer"
#zplug "vifon/deer", use:deer
zplug "urbainvaes/fzf-marks"
zplug "changyuheng/zsh-interactive-cd"

# }}} zplug plugins
# {{{ theme
# Load theme file
zplug 'eendroroy/alien', as:theme
# }}} theme
# {{{ theme settings
# # Load theme file
# zplug 'dracula/zsh', as:theme
export ALIEN_THEME="red"

color0=204      # time background color
color1=204      # normal background color
color1r=196     # normal error background color
color2=234      # time foreground color
color3=180      # user background color
color4=234      # user foreground color
color5=078      # dir background color
color6=234      # dir foreground color
# color7=180      # vcs background color
color8=204      # prompt foreground color
# color9=249      # vcs foreground color
#color10=244     # git left-right background color
#color11=255     # git left-right foreground color
#color12=253     # dirty copy background color
#color13=016     # dirty copy foreground color
#color14=245     # venv color

export USE_NERD_FONT=1
# }}} theme settings
# {{{ plugin settings

# {{{ deer
zle -N deer
#bindkey '\ek' deer
# }}} deer
# {{{ zce
# source ZPLUG_HOME/
bindkey "^Xz" zce
# }}} zce
# {{{ zsh-snippets
alias zsp="zsh_snippets"
# bindkey '^S^S' zsh-snippets-widget-expand  # CTRL-S CTRL-S (expand)
# bindkey '^S^A' zsh-snippets-widget-list    # CTRL-S CTRL-A (list)
# }}} zsh-snippets

# }}} Plugin settings

# }}} zplug plugins
# {{{ Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# }}} Install plugins if there are plugins that have not been installed
# {{{ Load zplug
zplug load #--verbose
# }}} Load zplug
# {{{ Basic Settings
export PRIVATE_CONFIG_DIR="$HOME/.priv_scripts"
export VISUAL=vim
export EDITOR="$VISUAL"
# export TERM="xterm"

# Set vimpager as pager
export PAGER=vimpager
alias less=$PAGER
alias zless=$PAGER
alias man='man -P vimpager'

# }}} Basic Settings
# {{{ Imports
source ~/tmuxinator.zsh
# source ~/.shell_prompt.sh
# }}} Imports
# {{{ path
PATH=$PATH:/home/jordan/.local/bin
PATH=$PATH:/home/jordan/.scripts
PATH=$PATH:/home/jordan/.gem/ruby/2.6.0/bin
QUBBD_DATA_PATH=/home/jordan/work/gleason/data/
# }}} path
# {{{ fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fzf_history() { zle -I; eval $(history | fzf +s | sed 's/ *[0-9]* *//') ; }; zle -N fzf_history; bindkey '^F' fzf_history

fzf_cd() { zle -I; DIR=$(find . -type d -print 2> /dev/null | fzf) && cd "$DIR" ; }; zle -N fzf_cd; bindkey '^E' fzf_cd

function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}

# fuzzy grep open via ag with line number
vg() {
  local file
  local line

  read -r file line <<<"$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

source $HOME/git_repos/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh

# }}} fzf
# {{{ config file aliases
alias config='/usr/bin/git --git-dir=$HOME/git_repos/mydotfiles --work-tree=$HOME'
alias cfg-awesome="vim ~/.config/awesome/rc.lua"
alias cfg-muttrc="vim ~/.muttrc"
alias cfg-nvim="vim ~/.config/nvim/init.vim"
alias cfg-taskrc="vim ~/.taskrc"
alias cfg-tmuxconf="vim ~/dot_files/.tmux.conf"
alias cfg-vimrc="vim ~/dot_files/.vimrc"
alias cfg-vitrc="vim ~/.vitrc"
alias cfg-zshrc="vim ~/.zshrc"
alias config='/usr/bin/git --git-dir=$HOME/git_repos/mydotfiles --work-tree=$HOME'
alias priv_config='/usr/bin/git --git-dir=$HOME/git_repos/private_dots --work-tree=$HOME'

# }}} config file aliases
# {{{ program aliases
alias c="cmus"
alias ve="emacs --no-window-system -q -l ~/.emacs.d/vanilla/init.el"
alias e="emacs --no-window-system -q -l ~/.emacs.d/main/init.el"
alias emacs='emacs -q -l ~/.emacs.d/main/init.el'
alias spacemacs='emacs -q -l ~/.emacs.d/spacemacs/init.el'
alias ipy="ipython"
alias ls="lsd" # or use ls --color
alias m="mutt"
alias n="nvim"
alias o="okular"
alias r="ranger"
alias t="tmux"
alias v="vim --cmd 'let g:elite_mode=1'"
alias vv="vim --cmd 'let g:Vanilla=1'"
alias vd="vim --cmd 'let g:DefaultVim=1'"
alias q="exit"
alias z="zathura"
#  }}} program aliases
#  {{{ Utility Aliases
alias cl="clear; ls"
#  }}} Utility Aliases
# {{{ Connection aliases
alias do_ssh="ssh -Y root@142.93.118.208"
# }}} Connection aliases
# {{{ Load private zsh script
if [ -d "$PRIVATE_CONFIG_DIR" ]; then
source $PRIVATE_CONFIG_DIR/priv_zsh.sh
fi
# }}} Load private zsh script
# {{{ User Defined Functions and bindings
cdl() { cd "$@" && clear && ls; }

up-a-directory() {
  emulate -L zsh
  echo
  cd ..
  ls
}

function chpwd() {
    emulate -L zsh
    ls
}

zle -N up-a-directory

bindkey '^k' up-a-directory

shdl() { curl -O $(curl -s http://sci-hub.tw/"$@" | grep location.href | sed -n "s/.*\(http.*pdf\).*/\1/p") ;}

se() { du -a ~/.scripts/* ~/.config/* | awk '{print $2}' | fzf | xargs  -r $EDITOR ;}
sp() { du -a ~/papers/* | awk '{print $2}' | fzf | xargs  -r zathura ;}
# sv() { vcopy "$(du -a ~/.scripts/* ~/.config/* | awk '{print $2}' | fzf)" ;}
vf() { fzf | xargs -r -I % $EDITOR % ;}


# }}} User Defined Functions and bindings
# {{{ Startup commands
#archey
#figlet -d ~/git_repos/figlet-fonts/tlf-contrib -f 'rebel' $HOST | lolcat
# fortune | ponysay
# }}} Startup commands

# unregister broken GHC packages. Run this a few times to resolve dependency rot in installed packages.
# ghc-pkg-clean -f cabal/dev/packages*.conf also works.
function ghc-pkg-clean() {
  for p in `ghc-pkg check $* 2>&1  | grep problems | awk '{print $6}' | sed -e 's/:$//'`
  do
    echo unregistering $p; ghc-pkg $* unregister $p
  done
}

# remove all installed GHC/cabal packages, leaving ~/.cabal binaries and docs in place.
# When all else fails, use this to get out of dependency hell and start over.
function ghc-pkg-reset() {
  if [[ $(readlink -f /proc/$$/exe) =~ zsh ]]; then
    read 'ans?Erasing all your user ghc and cabal packages - are you sure (y/N)? '
  else # assume bash/bash compatible otherwise
    read -p 'Erasing all your user ghc and cabal packages - are you sure (y/N)? ' ans
  fi

  [[ x$ans =~ "xy" ]] && ( \
    echo 'erasing directories under ~/.ghc'; command rm -rf `find ~/.ghc/* -maxdepth 1 -type d`; \
    echo 'erasing ~/.cabal/lib'; command rm -rf ~/.cabal/lib; \
  )
}

alias cabalupgrades="cabal list --installed  | egrep -iv '(synopsis|homepage|license)'"


PATH=$PATH:~/.cabal/bin

# {{{ ENV
HISTFILE=$HOME/.zsh_history
APPEND_HISTORY=TRUE
SAVEHIST=20
HISTSIZE=200
# }}} ENV

setopt append_history # append rather then overwrite
setopt extended_history # save timestamp
setopt inc_append_history # add history immediately after typing a command

# {{{ vim modelines
# vim: set foldmethod=marker:
# }}} vim modelines
