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
