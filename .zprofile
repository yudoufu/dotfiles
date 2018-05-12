
# original idea: http://www.gcd.org/blog/2006/09/100/
liveagent() {
    agent="$HOME/.ssh-agent-$USER"
    if [ -S "$SSH_AUTH_SOCK" ]; then
        case $SSH_AUTH_SOCK in
        /tmp/*/agent.[0-9]*)
            ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
        esac
    elif [ -S $agent ]; then
        export SSH_AUTH_SOCK=$agent
    else
        echo "no ssh-agent"
    fi
}
liveagent

agvim () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

# original: https://masawada.hatenablog.jp/entry/2015/02/02/210300
pfind() {
  local current_buffer=$BUFFER
  local file_path=""

  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    local search_root=`git rev-parse --show-toplevel`
    file_path="$(find $search_root | peco --prompt="repos: $search_root>")"
  else
    file_path="$(find . -maxdepth 5 | peco --prompt="`pwd`>")"
  fi
  BUFFER="${current_buffer} ${file_path}"
  CURSOR=$#BUFFER
  #zle clear-screen
}
zle -N pfind
bindkey '^f' pfind

