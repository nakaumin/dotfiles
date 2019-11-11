#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
fpath=(/usr/local/share/zsh-completions $fpath)

#------------------------------------------------------------
#  language and charcode
#------------------------------------------------------------

export LANG=ja_JP.UTF-8
export VTE_CJK_WIDTH=wide

#------------------------------------------------------------
#  general
#------------------------------------------------------------
umask 022

PATH=~/go/bin:"$PATH"
PATH=~/.composer/vendor/bin:"$PATH"
PATH=~/bin:"$PATH"
export PATH

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
#  fzf
#------------------------------------------------------------
#export FZF_DEFAULT_OPTS='--color=fg+:11 --height 70% --reverse --select-1 --exit-0 --multi'
export FZF_DEFAULT_OPTS='--color=fg+:11 --reverse --select-1 --exit-0 --multi'

#------------------------------------------------------------
#  fzf x cd
#------------------------------------------------------------
# cdrの設定
autoload -Uz is-at-least
if is-at-least 4.3.11
then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*'      recent-dirs-max 500
  zstyle ':chpwd:*'      recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi

# fzf-cdr 
alias c='fzf-cdr'
function fzf-cdr() {
  target_dir=`cdr -l | sed 's/^[^ ][^ ]*  *//' | fzf`
  target_dir=`echo ${target_dir/\~/$HOME}`
  if [ -n "$target_dir" ]; then
      cd $target_dir
  fi
}

# ghq
alias g='cd $(ghq root)/$(ghq list | fzf)'

# direcr cd to subdirectory
alias dive='cd $(find . -type d | fzf)'

#------------------------------------------------------------
#  fzf x git
#------------------------------------------------------------
alias add='fzf-add'
function fzf-add() {
  local selected
  selected="$(git status -s | fzf | cut -c3-)"
  if [ -n "$selected" ]; then
    echo $selected
    git add $selected
  fi
}

#------------------------------------------------------------
#  History
#------------------------------------------------------------

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# 重複を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups

# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space

# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# 古いコマンドと同じものは無視
setopt hist_save_no_dups

# historyコマンドは履歴に登録しない
setopt hist_no_store

# 補完時にヒストリを自動的に展開
setopt hist_expand

# 履歴をインクリメンタルに追加
setopt inc_append_history

function fzf-history-selection() {
  if [ `uname` = "Darwin" ]; then
      BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | fzf`
  elif [ `uname` = "Linux" ]; then
      BUFFER=`\\history -n 1 | tail -r  | awk '!a[$0]++' | fzf`
  fi
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N fzf-history-selection
bindkey '^R' fzf-history-selection

#------------------------------------------------------------
#  alias
#------------------------------------------------------------

# enable color support
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    #alias ls='ls --color=auto'
    alias grep='egrep -i --color=auto'
fi

# ls aliases
alias l='ls -1F'
alias ll='ls -lF'
alias la='ls -A'

# git
alias lg='git lg'
alias lga='git lga'
alias lgs='git lgs'
alias st='git st'

# easy ansible-playbook
alias ap='ansible-playbook deploy.yml'


#------------------------------------------------------------
#  Screen
#------------------------------------------------------------
if [ `uname` = "Linux" ]; then
  if [ $SHLVL = '1' ]; then
    screen -U -xR -S $USER
  fi
fi

# プロンプト表示毎にscreenのタイトルを現在のディレクトリ名に変更する
PROMPT_COMMAND='echo -ne "\033k\033\0134\033k$(basename "$PWD")\033\\"'

precmd() { eval "$PROMPT_COMMAND" }

#------------------------------------------------------------
#  MacOS
#------------------------------------------------------------

if [ `uname` = "Darwin" ]; then
  #------------------------------------------------------------
  # Keychain for SSH
  # SSH鍵管理をOSXのキーチェーンにさせない
  #------------------------------------------------------------
  if [ ! -f $HOME/.keychain/$HOSTNAME-sh ] ; then
    unset SSH_AUTH_SOCK
  fi
  eval `keychain --quiet --eval --agents ssh id_rsa`

  #------------------------------------------------------------
  # HOMEBREW
  #------------------------------------------------------------
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  #------------------------------------------------------------
  # PATH for gnu's g* comands
  #------------------------------------------------------------
  export PATH=/usr/local/opt/coreutils/bin:$PATH

  #------------------------------------------------------------
  #  alias
  #------------------------------------------------------------
  alias find=gfind
  alias xargs=gxargs
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
