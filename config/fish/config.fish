#------------------------------------------------------------
#  Base
#------------------------------------------------------------
# 環境変数
set -x LANG ja_JP.UTF-8
set -x PATH $HOME/bin/macos $PATH
set -x PATH $HOME/go/bin $PATH
set -x PATH $HOME/bin $PATH
set -x MANPAGER "/bin/sh -c \"col -b -x|vim -R -c 'set ft=man nolist nonu noma' -\""

# alias
alias gr='ghq root'
alias g='cd (gr)/(ghq list | peco)'
alias G='echo (gr)/(ghq list | peco)'

alias l='ls -G -1'

alias lga='git lga'
alias lgs='git lgs'
alias lg='git lg'

if test (uname) = 'Darwin'
  alias find='gfind'
end

#------------------------------------------------------------
#  SSH AUTH SOCK
#------------------------------------------------------------
if test -n {$SSH_AUTH_SOCK}
  bash -c 'find /tmp/ssh-* -name "agent.*" -exec ln -sf {} ~/.ssh-sock \;' >/dev/null ^/dev/null
  if test -e $HOME/.ssh-sock 
    set -x SSH_AUTH_SOCK $HOME/.ssh-sock
  end
end

# Restore screen title
# SSH中かどうか判定するべき
function dostuff --on-event fish_prompt
  set title (basename (pwd))
  echo -ne "\ek$title\e\\"
end

#------------------------------------------------------------
#  Fisherman plugins
#------------------------------------------------------------

# THEME PURE #
set fish_function_path ~/.config/fish/functions/theme-pure $fish_function_path

#------------------------------------------------------------
#  Run screen 
#------------------------------------------------------------

#screenの自動実行
if test {$SHLVL} = '1' 
  screen -U -xR -S $USER
end

#fish_vi_key_bindings

