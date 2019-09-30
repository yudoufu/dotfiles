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

## $B=*N;;~$K(Bhup$B$7$J$$(B
setopt nohup

## interacitive shell$B>e$G$b(B#$B0J9_$r%3%a%s%H07$$$9$k(B
setopt interactive_comments

## Ctrl-s/Ctrl-q $B$K$h$k=PNO@)8f$r9T$o$J$$(B
setopt no_flow_control

## background job$B$N>uBVJQ2=$rDLCN$9$k(B
setopt notify

## $B6h@Z$jJ8;z$G(Bbackward$B$9$k(B
# WORDCHARS$B$N@_Dj$G$O%^%k%A%P%$%H$KBP1~$G$-$J$$$?$a!"(Bselect-word-style$B$r;H$&(B
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/select-word-style
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified

# ----------------------------------------------------------------------------
# Completion Configuration

## $B0z?t$N(B=$BEy0J9_$G$b(Bpath$B$NJd40$rM-8z$K$9$k(B
setopt magic_equal_subst

## $BJd405!G=$NM-8z2=(B
autoload -Uz compinit
compinit

## $BBgJ8;z>.J8;z$r6hJL$7$J$$(B
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## $B%Q%9F~NOJd40;~$K(BC-n,b,f,p $B$rM-8z$K$9$k(B
zstyle ':completion:*:default' menu select=1

## $BJd40$K?'$rIU$1$k(B (default: '')
zstyle ':completion:*:default' list-colors ''

# ----------------------------------------------------------------------------
# History Configuration

## $B%R%9%H%j%5%$%:$N@_Dj$rHs>o$KBg$-$/$9$k(B
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=$HISTSIZE

## $B%R%9%H%j%U%!%$%k$K;~9o$bJ]B8$9$k(B
setopt extended_history

## $BF1$8%3%^%s%I$rO"B3$7$?>l9g$K$OJ]B8$7$J$$(B
setopt hist_ignore_dups

## $BITMW$J6uGr$r5M$a$FJ]B8$9$k(B
setopt hist_reduce_blanks

## $B$9$0$K%R%9%H%j$KJ]B8$9$k(B
setopt inc_append_history

## zsh$B%W%m%;%94V$G%R%9%H%j$r6&M-$9$k(B
setopt share_history

## $B%3%^%s%I$NESCf$+$i(Bhistory$B$r9J$j9~$`(B
# ^p, ^n $B$rDY$9$HJd40$N(Bmenu select$B$HB>$H43>D$9$k$N$G(B meta-key$B$KEv$F$k(B
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

