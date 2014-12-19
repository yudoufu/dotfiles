#!/bin/bash
set -e

RUBY_VERSION=2.1.4
PYTHON_VERSION=3.4.2
PERL_VERSION=5.21.5
NODE_VERSION=0.10.33

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

main() {
    real_script_dir=$(dirname $(readlink -f $0))
    script_dir=$(cd $(dirname $0); pwd)
    opts=`getopt -o hvo: -l help,verbose,option:,dry, -- "$@"`
    eval set -- "$opts"
    while [ -n "$1" ]; do
        case $1 in
            -h|--help) usage;;
            -o|--option) option=$2; shift;;
            -v|--verbose) is_verbose=1;;
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

    install_langenv
    otherenv
    make_lang
}

install_langenv() {
    install_rbenv
    install_pyenv
    install_plenv
    install_nvm
}

make_lang() {
    make_ruby $RUBY_VERSION
    make_python $PYTHON_VERSION
    make_perl $PERL_VERSION
    make_node $NODE_VERSION
}

install_rbenv() {
    local path=$prefix/.rbenv
    local build_path=$path/plugins/ruby-build
    git clone git://github.com/sstephenson/rbenv.git $path
    git clone git://github.com/sstephenson/ruby-build.git $build_path
    echo "export PATH=$path/bin:\$PATH" >> $local_profile
    echo 'eval "$(rbenv init -)"' >> $local_profile
}

install_pyenv() {
    local path=$prefix/.pyenv
    local venv_path=$path/plugins/python-virtualenv
    git clone git://github.com/yyuu/pyenv.git $path
    git clone git://github.com/yyuu/python-virtualenv.git $venv_path
    echo "export PATH=$path/bin:\$PATH" >> $local_profile
    echo 'eval "$(pyenv init -)"' >> $local_profile
}

install_plenv() {
    local path=$prefix/.plenv
    git clone git://github.com/tokuhirom/plenv.git $path
    echo "export PATH=$path/bin:\$PATH" >> $local_profile
    echo 'eval "$(plenv init -)"' >> $local_profile
}

install_nvm() {
    local path=$prefix/.nvm
    git clone git://github.com/creationix/nvm.git $path
    echo "source $path/nvm.sh" >> $local_profile
}

make_ruby() {
    local version=$1
    rbenv install $version
    cd $prefix; rbenv local $version
    rbenv exec gem install bundler --no-ri --no-rdoc
    rbenv rehash
}

make_python() {
    local version=$1
    pyenv install $version
    cd $prefix; pyenv local $version
    pyenv rehash
}

make_perl() {
    local version=$1
    plenv install $version
    cd $prefix; pyenv local $version
    plenv install-cpan
    plenv rehash
}

make_node() {
    local version=$1
    nvm install v$version
    nvm use v$verbose
    nvm alias default v$version
}

otherenv() {
    mkdir -p $HOME/bin
	echo 'export PATH="$HOME/bin:$PATH"' >> $local_profile
	echo "export MAKEOPTS=\"-j $(shell expr `cat /proc/cpuinfo |grep processor |wc -l` + 2)\"" >> $local_profile
}

## utility
run() {
    if [ $is_dry ]; then
        echo "[dry run] $@"
    else
        if [ $is_verbose ];then
            echo "[run] $@"
        fi
        eval "$@"
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

gray() {
    echo -n "[1;30m$1[0m"
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

debug() {
    if [ $is_dry ] || [ $is_verbose ];then
        gray "[debug] "
        echo "$1"
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
main "$@"

