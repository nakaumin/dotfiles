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

# for Mac
if [ `uname` = "Darwin" ]; then
    alias ls='ls -G'
fi

alias G='egrep -i'
alias X='xargs'

# ls aliases
alias l='ls -1'
alias ll='ls -l'
alias la='ls -A'
export LSCOLORS=cxfxcxdxbxegedabagacad

# git
alias cm='git commit'
alias co='git checkout'
alias lg='git lg'
alias lga='git lga'
alias lgs='git lgs'
alias st='git st'
alias br='git branch'
alias ad='git add'
alias adp='git add -p'
alias rb='git rebase'
alias re='git reset'
alias rh='git reset --hard'
alias mg='git merge'
alias push='git push'
alias pull='git pull'
alias fetch='git fetch'
alias stash='git stash'

# ghq
alias g='cd $(ghq root)/$(ghq list | peco)'

# easy ansible-playbook
alias ap='ansible-playbook deploy.yml'

#------------------------------------------------------------
#  Completion
#------------------------------------------------------------

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# for MacOS?
if [ -d /usr/local/etc/bash_completion.d/ ]; then
  source /usr/local/etc/bash_completion.d/git-prompt.sh
  source /usr/local/etc/bash_completion.d/git-completion.bash 
fi

if [ -f /usr/share/bash-completion/completions/git ]; then
  source /usr/share/bash-completion/completions/git
fi

__git_complete cm _git_commit
__git_complete co _git_checkout
__git_complete lg _git_lg
__git_complete lga _git_log
__git_complete lgs _git_log
__git_complete st _git_status
__git_complete br _git_branch
__git_complete ad _git_add
__git_complete adp _git_add
__git_complete rb _git_rebase
__git_complete re _git_reset
__git_complete rh _git_reset
__git_complete mg _git_merge
__git_complete push _git_push
__git_complete pull _git_pull
__git_complete fetch _git_fetch
__git_complete stash _git_stash

#------------------------------------------------------------
#  Utility
#------------------------------------------------------------

fvim() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf --preview 'head -100 {}') &&
  vim $selected_files
}

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

PS1=$PS1_GIT

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

  #------------------------------------------------------------
  #  iTerm2
  #------------------------------------------------------------
  # tab-color [R] [G] [B]
  tab-color() {
      echo -ne "\033]6;1;bg;red;brightness;$1\a"
      echo -ne "\033]6;1;bg;green;brightness;$2\a"
      echo -ne "\033]6;1;bg;blue;brightness;$3\a"
  }
  #変更をリセット
  tab-reset() {
      echo -ne "\033]6;1;bg;*;default\a"
  }

  alias tab-prod='tab-color 204 0 0' #赤
  alias tab-staging='tab-color 255 255 0' #黄色
  alias tab-dev='tab-color 134 200 0' #緑

  # SSHの前後でiTermのタブの色を変える
  ssh() {
    tab-color 255 100 0
    if command ssh "$@"; then
      tab-reset
        # commands go here
    fi
  }
fi

#------------------------------------------------------------
#  GitHub cli
#------------------------------------------------------------
if type "gh" > /dev/null 2>&1
then
  eval "$(gh completion -s bash)"
fi

