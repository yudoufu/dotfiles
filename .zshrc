if [ "$(uname)" != "Darwin" ] && [ $(which screen 2>/dev/null) ] && [ ! $STY ]; then
    exec screen -xRR
fi

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
#export ZSH_THEME="random"
export ZSH_THEME="tjkirch"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git svn django)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
umask 002

setopt nohup
setopt magic_equal_subst     # コマンドラインの引数で --PREFIX=/USR などの = 以降でも補完できる
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt list_packed           # コンパクトに補完リストを表示

autoload zmv
alias zmv='noglob zmv -W'

if [ `uname` = 'Linux' ] && [ `lsb_release -si` = 'Debian' ]; then
    alias sudo='PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH sudo -E '
fi

# history search keybind
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

export GOPATH="$HOME/opt/go"

# include local specific settings if exist.
[ -f ~/.zsh_local ] && source ~/.zsh_local
