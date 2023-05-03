#!/bin/sh

export BASH_SILENCE_DEPRECATION_WARNING=1

#------------------------------------------------------------
#  load .bashrc
#------------------------------------------------------------

#PATH="/usr/local/opt/php@7.4/bin:$PATH"
#PATH="/usr/local/opt/php@7.4/sbin:$PATH"
PATH="$HOME/.symfony/bin:$PATH"
PATH=$HOME/.local/bin:$PATH
PATH=~/ghq/github.com/clood-jp/bin:"$PATH"
PATH=~/bin:"$PATH"
PATH=~/bin/vendor:"$PATH"
PATH=~/go/bin:"$PATH"
PATH=~/.composer/vendor/bin:"$PATH"
PATH=/usr/local/bin:"$PATH"
PATH=/usr/local/sbin:"$PATH"
PATH=/opt/homebrew/bin:"$PATH"
PATH=/opt/homebrew/bin:"$PATH"
PATH=/usr/local/opt/php@8.0/bin:"$PATH"
PATH=/usr/local/opt/php@8.0/sbin:"$PATH"

# 優先順位高
export PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi

# 優先順位高
if [ -e "$HOME/.nodenv" ]
then
    export NODENV_ROOT="$HOME/.nodenv"
    export PATH="$NODENV_ROOT/bin:$PATH"
    if command -v nodenv 1>/dev/null 2>&1
    then
        eval "$(nodenv init -)"
    fi
fi

export PATH

if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

