##
# .zshrc
#
# see: http://zsh.sourceforge.net/Doc/Release/index.html

# ----------------------------------------------------------------------------
# Authority

umask 002

# ----------------------------------------------------------------------------
# Interactive shell control

bindkey -e

## colors enabled
autoload -Uz colors
colors

## 終了時にhupしない
setopt nohup

## interacitive shell上でも#以降をコメント扱いする
setopt interactive_comments

## Ctrl-s/Ctrl-q による出力制御を行わない
setopt no_flow_control

## background jobの状態変化を通知する
setopt notify

## 区切り文字でbackwardする
# WORDCHARSの設定ではマルチバイトに対応できないため、select-word-styleを使う
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/select-word-style
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified

# ----------------------------------------------------------------------------
# Completion Configuration

## 引数の=等以降でもpathの補完を有効にする
setopt magic_equal_subst

## 補完機能の有効化
autoload -Uz compinit
compinit

## 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## パス入力補完時にC-n,b,f,p を有効にする
zstyle ':completion:*:default' menu select=1

## 補完に色を付ける (default: '')
zstyle ':completion:*:default' list-colors ''

# ----------------------------------------------------------------------------
# History Configuration

## ヒストリサイズの設定を非常に大きくする
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=$HISTSIZE

## ヒストリファイルに時刻も保存する
setopt extended_history

## 同じコマンドを連続した場合には保存しない
setopt hist_ignore_dups

## 不要な空白を詰めて保存する
setopt hist_reduce_blanks

## すぐにヒストリに保存する
setopt inc_append_history

## zshプロセス間でヒストリを共有する
setopt share_history

## コマンドの途中からhistoryを絞り込む
# ^p, ^n を潰すと補完のmenu selectと他と干渉するので meta-keyに当てる
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/history-search-end
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[p' history-beginning-search-backward-end
bindkey '^[n' history-beginning-search-forward-end

## incremental history search(can use wildcard)
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# ----------------------------------------------------------------------------
# Prompt

## pure
# https://github.com/zsh-users/zsh/tree/master/Functions/Prompts
# https://github.com/sindresorhus/pure
autoload -U promptinit
promptinit
prompt pure
PURE_PROMPT_SYMBOL='%(?.%F{cyan}.%F{red})%#'
PROMPT='%F{240}%D{%Y/%m/%f} %F{white}%* '$PROMPT

# ----------------------------------------------------------------------------
# Common Aliases

alias grep='grep --color=auto'
$(which tree > /dev/null) && alias tall='tree -C -ugh'
$(which nvim > /dev/null) && alias vi=nvim

if $(which peco > /dev/null); then
  function _peco-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | awk '!a[$0]++'| peco --prompt='history>' --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle -R -c
  }

  zle -N _peco-history
  bindkey '^R' _peco-history
fi

if $(which ghq > /dev/null) && $(which peco > /dev/null); then
  function _peco-ghq() {
    local args="$*"
    local selected="$(ghq list | peco --prompt='ghq>' --query=$args)"
    if [ -n "$selected" ];then
      cd "$(ghq root)/$selected"
    fi
  }

  alias ghqp=_peco-ghq
fi

# ----------------------------------------------------------------------------
# Load modules (temporary write. TODO: move to modules each files.)

autoload -Uz zmv
alias zmv='noglob zmv -W'

# ----------------------------------------------------------------------------
# Plugin setttings

## System specified
[ -f ~/.zshrc.${$(uname):l} ] && source ~/.zshrc.${$(uname):l}

## modules
[ -d ~/.zsh.d ] && for file (~/.zsh.d/*.zsh(N)) source $file

## local only
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

