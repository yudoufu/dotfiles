#!/bin/bash
set -e

main() {
  readonly dotfile_dir="$HOME/.dotfiles"

  download
  execute
}

download() {
  local repository="git@github.com:yudoufu/dotfiles.git"
  local tarball="https://github.com/yudoufu/dotfiles/archive/master.tar.gz"

  if has_git; then

    if [ -d "$dotfile_dir" ]; then
      cd "$dotfile_dir"
      git pull
      git submodule update --init
      git submodule foreach 'git checkout master; git pull'
    else
      git clone --recursive "$repository" "$dotfile_dir"
    fi

  elif has_curl || has_wget; then

    if has_curl; then
      curl -L "$tarball"
    elif has_wget; then
      wget -O - "$tarball"
    fi | tar xz

    if [ ! -d "dotfiles-master" ]; then
      echo "dotfiles-master doesn't exist." >&2
      exit 1
    fi

    mv -f "dotfiles-master" "$dotfile_dir"

  else
    echo "Don't exist download tools. Please install git or curl/wget."
    exit 1
  fi
}

execute() {
  /bin/bash "$dotfile_dir/etc/setup.sh"
}

has_git() {
  return $(has_cmd "git")
}

has_curl() {
  return $(has_cmd "curl")
}

has_wget() {
  return $(has_cmd "wget")
}

has_cmd() {
  return $(type "$@" > /dev/null 2>&1)
}

main "$@"

