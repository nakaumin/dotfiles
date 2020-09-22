#!/bin/sh

export BASH_SILENCE_DEPRECATION_WARNING=1

#------------------------------------------------------------
#  load .bashrc
#------------------------------------------------------------

if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

export PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi


