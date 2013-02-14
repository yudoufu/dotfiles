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
    opts=`getopt -o ho: -l help,option:, -- "$@"`
    eval set -- "$opts"
    while [ -n "$1" ]; do
        case $1 in
            -h|--help) usage;;
            -o|--option) option=$2; shift;;
            --dry) is_dry=1;;
            --) break;;
            *) usage;;
        esac
        shift
    done

    if [ $is_dry ];then
        echo "dry run..."
    fi

    # implement here. #

}

## utility
execute() {
    if [ $is_dry ]; then
        echo "[dry run] $1"
    else
        echo "[run] $1"
        eval $1
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

fatal() {
    red "[fatal] $1"
}

warn() {
    yellow "[warn] $1"
}

info() {
    green "[info] $1"
}

# call main.
main "$@"
