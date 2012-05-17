#!/bin/sh

#------------------------------------------------------------
#  execution path 
#------------------------------------------------------------

export PATH=~/bin:~/bin/du-bin:~/bin/vendor:~/go/bin:~/bin/mac:~/bin/ubuntu:/usr/local/bin:/usr/local/sbin:"$PATH"

#------------------------------------------------------------
#  language and charcode 
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
#  load environmental profiles
#------------------------------------------------------------

# for macos
if [ `uname` = "Darwin" ]; then
  if [ -f ~/.bash_profile.mac ]; then
  . ~/.bash_profile.mac
  fi
fi

#------------------------------------------------------------
#  load .bashrc
#------------------------------------------------------------

if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

