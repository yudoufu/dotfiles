#!/bin/bash
set -e

usage() {
  echo "USAGE: `basename $0` [Options]"
  echo ""
  echo "Required:"
  echo ""
  echo "Options:"
  echo "  -h, --help          show this help."
  echo "  -v, --verbose       show detail commands."
  echo "  --dry               dry run mode."
  exit 1;
}

initialize() {
  # set file-scope variables
  readonly script_dir=$(cd $(dirname $0); pwd)
  readonly project_dir=$(cd "$script_dir/../"; pwd)

  declare -a argv=()
  while (( $# > 0 )); do
    case $1 in
      -h|--help) usage;;
      -o|--option) option=$2; shift;;
      --dry) is_dry=1;;
      -v|--verbose) is_verbose=1;;
      -*) fatal "Unkown option: $1"; usage;;
      *) argv=("${argv[@]}" "$1");;
    esac
    shift
  done
  set -- "${argv[@]}"

  if [ $is_dry ];then
    info "dry run..."
  fi

  main "$@"
}

main() {
  setup_zsh
  setup_git
  setup_neovim
  setup_misc
}

setup_zsh() {
  debug "Setup zsh environments"

  local target_dir=$HOME
  local source_dir="$project_dir/resources/zsh"

  links "$source_dir" "$target_dir"
}

setup_git() {
  debug "Setup git environmets"

  local target_dir=$HOME
  local source_dir="$project_dir/resources/git"

  links "$source_dir" "$target_dir"
}

setup_neovim() {
  debug "Setup neovim environments"

  local target_dir=$HOME
  local source_dir="$project_dir/resources/nvim"

  symlink "$source_dir/init.vim" "$target_dir/.vimrc"
  symlink "$source_dir" "$target_dir/.vim"

  run mkdir -p "$target_dir/.config"
  symlink "$source_dir" "$target_dir/.config/nvim"
}

setup_misc() {
  debug "Setup misc environments"

  local target_dir=$HOME
  local source_dir="$project_dir/resources/misc"

  links "$source_dir" "$target_dir"
}

links() {
  local source_dir=$1
  local dest_dir=$2

  for resource in $(ls -A $source_dir); do
    symlink "$source_dir/$resource" "$dest_dir/$resource"
  done
}

symlink() {
  local source=$1
  local dest=$2

  run ln -fvs "$source" "$dest"
}

## utility
run() {
  if [ $is_dry ]; then
    echo "[dry-run] $@"
  else
    if [ $is_verbose ];then
      echo "[run] $@"
    fi
    eval "$@"
  fi
}

red() {
  echo "[1;31m$1[0m"
}

yellow() {
  echo "[1;33m$1[0m"
}

green() {
  echo "[1;32m$1[0m"
}

gray() {
  echo "[1;30m$1[0m"
}

fatal() {
  echo "[$(red fatal)] $1" >&2
}

warn() {
  echo "[$(yellow warn)] $1" >&2
}

info() {
  echo "[$(green info)] $1"
}

debug() {
  if [ $is_dry ] || [ $is_verbose ];then
    echo "[$(gray debug)] $1"
  fi
}

success() {
  echo "[ $(green OK) ] $1"
}

failure() {
  echo "[ $(red NG) ] $1"
}

judge() {
  if [ $1 -eq 0 ];then
    success $2
  else
    failure $2
  fi
}

is_numeric() {
  local value=$1
  expr "$value" : "[0-9]*" > /dev/null
  return $?
}

is_absolute() {
  local path=$(echo $1)
  [ "${path:0:1}" = "/" ]
  return $?
}

resolve_path() {
  local path=$1
  if is_absolute $path; then
    echo $(echo $path)
  else
    echo $(echo `pwd`/$path)
  fi
}

# call main.
initialize "$@"

