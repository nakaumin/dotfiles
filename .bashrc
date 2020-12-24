#!/bin/bash
# If not running interactively, don't do anything
# [ -z "$PS1" ] && return

#------------------------------------------------------------
#  PATH
#------------------------------------------------------------

# to override PROMPT
if [ -f ~/.env ]; then
. ~/.env
fi

PATH=~/bin:"$PATH"
PATH=~/bin/vendor:"$PATH"
PATH=~/go/bin:"$PATH"
PATH=~/.composer/vendor/bin:"$PATH"
PATH=/usr/local/bin:"$PATH"
PATH=/usr/local/sbin:"$PATH"
PATH=/opt/homebrew/bin:"$PATH"
export PATH

#------------------------------------------------------------
#  Language and encoding
#------------------------------------------------------------

export LANG=ja_JP.UTF-8
export VTE_CJK_WIDTH=wide

#------------------------------------------------------------
#  SSH AUTH SOCK
#------------------------------------------------------------

if [ -n $SSH_AUTH_SOCK ] ;then
  find /tmp/ssh-* -name "agent.*" -exec ln -sf {} ~/.ssh-sock \; 2>/dev/null
  if [ -e $HOME/.ssh-sock ]; then
    export SSH_AUTH_SOCK=$HOME/.ssh-sock
  fi
fi

#------------------------------------------------------------
#  General
#------------------------------------------------------------

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
umask 022

#------------------------------------------------------------
#  Key bindings 
#------------------------------------------------------------

#disable C-s on bash
if [ “$SSH_TTY” != “” ]; then
  stty start undef
  stty stop undef
fi

#set vi mode
set -o vi

#------------------------------------------------------------
#  History
#------------------------------------------------------------

HISTCONTROL=erasedups
HISTSIZE=50000
HISTFILESIZE=50000  
HISTIGNORE=cd:history:ls:ll
HISTTIMEFORMAT='%F %T '

# share history
function share_history {
  history -a  # append to .bash_history
  history -c  # clear local history
  history -r  # restore from .bash_history
}

PROMPT_COMMAND='share_history'  
shopt -u histappend   # disable default history-append setting

#------------------------------------------------------------
#  Alias
#------------------------------------------------------------

# enable color support 
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep='egrep -i --color=auto'
fi

# ls aliases
alias l='ls -1'
alias ll='ls -l'
alias la='ls -A'

# git
alias gf='git fetch'
alias pl='git pull'
alias cm='git commit'
alias co='git checkout'
alias lg='git lg'
alias lga='git lga'
alias lgs='git lgs'
alias st='git st'

# ghq
alias g='cd $(ghq root)/$(ghq list | peco)'

# easy ansible-playbook
alias ap='ansible-playbook deploy.yml'

#------------------------------------------------------------
#  Utility
#------------------------------------------------------------

fvim() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf --preview 'head -100 {}') &&
  vim $selected_files
}

#------------------------------------------------------------
#  Completion
#------------------------------------------------------------

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#directory-completion with tail-slash
set mark-directories on

#------------------------------------------------------------
#  Colors and prompt 
#------------------------------------------------------------

COLOR_RESET="\[\033[00m\]"

COLOR_BLACK="\[\033[0;30m\]"
COLOR_RED="\[\033[0;31m\]"
COLOR_GREEN="\[\033[0;32m\]"
COLOR_YELLOW="\[\033[0;33m\]"
COLOR_BLUE="\[\033[0;34m\]"
COLOR_PURPLE="\[\033[0;35m\]"
COLOR_CYAN="\[\033[0;36m\]"
COLOR_WHITE="\[\033[0;37m\]"
COLOR_BRIGHT_BLACK="\[\033[1;30m\]"
COLOR_BRIGHT_RED="\[\033[1;31m\]"
COLOR_BRIGHT_GREEN="\[\033[1;32m\]"
COLOR_BRIGHT_YELLOW="\[\033[1;33m\]"
COLOR_BRIGHT_BLUE="\[\033[1;34m\]"
COLOR_BRIGHT_PURPLE="\[\033[1;35m\]"
COLOR_BRIGHT_CYAN="\[\033[1;36m\]"
COLOR_BRIGHT_WHITE="\[\033[1;37m\]"

PWD_COLOR=$COLOR_BRIGHT_GREEN
#HOST_COLOR=$COLOR_BRIGHT_GREEN
#USER_COLOR=$COLOR_BRIGHT_RED
PROMPT_COLOR=$COLOR_BRIGHT_RED

# for Mac
if [ `uname` = "Darwin" ]; then
  HOST_COLOR=$COLOR_CYAN
  USER_COLOR=$COLOR_CYAN
  PWD_COLOR=$COLOR_CYAN
  PROMPT_COLOR=$COLOR_WHITE
fi

# for git
function __git_psx() {
  __git_ps1 | perl -pe "s/\((.*)\)/\1/" 
}

PS1_BASE="$PWD_COLOR\w$COLOR_RESET$PROMPT_COLOR>$COLOR_RESET "
# show git info
PS1_GIT="$PWD_COLOR\w$COLOR_YELLOW"' $(__git_psx)'"$PROMPT_COLOR>$COLOR_RESET "
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

if [ -f $BASH_COMPLETION_DIR/git ]; then
  PS1=$PS1_GIT
elif [ -n "${BASH_COMPLETION_COMPAT_DIR-}" ]; then
  # for ubnutu 14.04
  PS1=$PS1_GIT
elif [ -d "/usr/local/etc/bash_completion.d" ]; then
  # for macos
  source /usr/local/etc/bash_completion.d/git-prompt.sh
  source /usr/local/etc/bash_completion.d/git-completion.bash 
  PS1=$PS1_GIT
else
  PS1=$PS1_BASE
fi

# to override PROMPT
if [ -f ~/.bash_colors.local ]; then
. ~/.bash_colors.local
fi

#------------------------------------------------------------
#  Screen
#------------------------------------------------------------
# Linuxの場合のみscreenを起動
if [ `uname` = "Linux" ]; then
#  if [ $SHLVL = '1' ]; then
#    screen -U -xR -S $USER
#  fi
  if [ $SHLVL = '1' -a "$TERM" != 'screen' -a "$TERM" != 'dumb' ]; then # dumb = scp
    screen -U -xR -S $USER
  fi
fi

# プロンプト表示毎にscreenのタイトルを現在のディレクトリ名に変更する
PROMPT_COMMAND=${PROMPT_COMMAND}' && echo -ne "\033k\033\0134\033k$(basename "$PWD")\033\\"'

#------------------------------------------------------------
#  Load extra environmental settings
#------------------------------------------------------------

# for local
if [ -f ~/.bashrc.local ]; then
. ~/.bashrc.local
fi

#------------------------------------------------------------
#  Xenv
#------------------------------------------------------------

# pyenvさんに~/.pyenvではなく、/usr/loca/var/pyenvを使うようにお願いする
export PYENV_ROOT=/usr/local/var/pyenv

# pyenvさんに自動補完機能を提供してもらう
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

#------------------------------------------------------------
#  Fzf
#------------------------------------------------------------

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#------------------------------------------------------------
#  For mac
#------------------------------------------------------------
if [ `uname` = "Darwin" ]; then
  # GNU utils
  alias find=gfind
  alias xargs=gxargs

  # SSH鍵管理をOSXのキーチェーンにさせない
  if [ ! -f $HOME/.keychain/$HOSTNAME-sh ] ; then
    unset SSH_AUTH_SOCK
  fi
  eval `keychain --quiet --eval --agents ssh id_rsa`
fi
