export BASH_SILENCE_DEPRECATION_WARNING=1

#------------------------------------------------------------
#  load .bash_common
#------------------------------------------------------------

if [ -f ~/.bash_common ]; then
. ~/.bash_common
fi


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
