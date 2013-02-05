#!/bin/sh
set -e

usage() {
    echo "USAGE: `basename $0` [Options]"
    echo ""
    echo "Required:"
    echo ""
    echo "Options:"
    echo "  -h, --help          show this help."
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
}

## utility
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
    red "$1"
}

warn() {
    yellow "$1"
}

info() {
    green "$1"
}

# call main.
main "$@"
