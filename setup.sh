#!/bin/sh
set -e

usage() {
    echo "USAGE: `basename $0` [Options]"
    echo ""
    echo "Required:"
    echo ""
    echo "Options:"
    echo "  -h, --help          show this help."
    echo "  --dry               dry run mode."
    exit 1;
}

main() {
    script_dir=$(cd $(dirname $0); pwd)
    opts=`getopt -o ho: -l help,option:,dry, -- "$@"`
    eval set -- "$opts"
    while [ -n "$1" ]; do
        case $1 in
            -h|--help) usage;;
            -o|--option) option=$2; shift;;
            --dry) is_dry=1;;
            --) shift; break;;
            *) usage;;
        esac
        shift
    done

    if [ $is_dry ];then
        info "dry run..."
    fi

    # implement here. #

}

install_rbenv() {
    path=$prefix/.rbenv
    build_path=$path/plugins/ruby-build
    git clone git://github.com/sstephenson/rbenv.git $path
    git clone git://github.com/sstephenson/ruby-build.git $build_path
    echo "export PATH=$path/bin:\$PATH" >> $local_profile
    echo 'eval "$(rbenv init -)"' >> $local_profile
}

install_pyenv() {
    path=$prefix/.pyenv
    venv_path=$path/plugins/python-virtualenv
    git clone git://github.com/yyuu/pyenv.git $path
    git clone git://github.com/yyuu/python-virtualenv.git $venv_path
    echo "export PATH=$path/bin:\$PATH" >> $local_profile
    echo 'eval "$(pyenv init -)"' >> $local_profile
}

install_plenv() {
    path=$prefix/.plenv
    git clone git://github.com/tokuhirom/plenv.git $path
    echo "export PATH=$path/bin:\$PATH" >> $local_profile
    echo 'eval "$(plenv init -)"' >> $local_profile
}

install_nvm() {
    path=$prefix/.nvm
    git clone git://github.com/creationix/nvm.git $path
    echo 'source $(NVM_PATH)/nvm.sh' >> $local_profile
}

install_ruby() {
}

install_python() {
}

install_perl() {
}

install_node() {
}

set_otherenv() {
  echo "export MAKEOPTS='-j $(expr `cat /proc/cpuinfo |grep processor |wc -l` + 2)'" >> $local_profile
}


## utility
run() {
    if [ $is_dry ]; then
        echo "[dry run] $@"
    else
        echo "[run] $@"
        "$@"
    fi
}

red() {
    echo -n "[1;31m$1[0m"
}

yellow() {
    echo -n "[1;33m$1[0m"
}

green() {
    echo -n "[1;32m$1[0m"
}

fatal() {
    red "[fatal] "
    echo "$1"
}

warn() {
    yellow "[warn] "
    echo "$1"
}

info() {
    green "[info] "
    echo "$1"
}

# call main.
main "$@"

