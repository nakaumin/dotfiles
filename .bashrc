#!/bin/bash
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#------------------------------------------------------------
#  general
#------------------------------------------------------------

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
umask 022

#------------------------------------------------------------
#  key setting
#------------------------------------------------------------

#disable C-s on bash
stty stop undef

#set vi mode
set -o vi

#------------------------------------------------------------
#  history
#------------------------------------------------------------

HISTCONTROL=erasedups
HISTSIZE=50000
HISTFILESIZE=50000  
HISTIGNORE=cd:history:ls:ll

# share history
function share_history {
  history -a  # append to .bash_history
  history -c  # clear local history
  history -r  # restore from .bash_history
}

PROMPT_COMMAND='share_history'  
shopt -u histappend   # disable default history-append setting

#------------------------------------------------------------
#  alias
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
alias lg='git lg'
alias lga='git lga'
alias lgs='git lgs'
alias st='git st'

# ghq
alias g='cd $(ghq root)/$(ghq list | peco)'

# easy ansible-playbook
alias ap='ansible-playbook deploy.yml'

#------------------------------------------------------------
#  completion
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
#  colors and prompt 
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

# load local color settings
# to override (HOST|USER|PROMPT)_COLOR
if [ -f ~/.bash_colors.local ]; then
. ~/.bash_colors.local
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

#------------------------------------------------------------
#  load environmental settings
#------------------------------------------------------------

# for macos
if [ `uname` = "Darwin" ]; then
  if [ -f ~/.bashrc.mac ]; then
  . ~/.bashrc.mac
  fi
fi

# for local
if [ -f ~/.bashrc.local ]; then
. ~/.bashrc.local
fi

#------------------------------------------------------------
#  run screen
#------------------------------------------------------------
if [ $SHLVL = '1' ]; then
  screen -U -xR -S $USER
fi

# プロンプト表示毎にscreenのタイトルを現在のディレクトリ名に変更する
PROMPT_COMMAND=${PROMPT_COMMAND}' && echo -ne "\033k\033\0134\033k$(basename "$PWD")\033\\"'
