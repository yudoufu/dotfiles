#!/bin/sh
set -e

usage() {
    echo "USAGE: `basename $0` [Options]"
    echo ""
    echo "Required:"
    echo ""
    echo "Options:"
    echo "  -h, --help          ヘルプを表示する"
    exit 1;
}

OPTS=`getopt -o ho: -l help,option:, -- "$@"`
eval set -- "$OPTS"
while [ -n "$1" ]; do
    case $1 in
        -h|--help) usage;;
        -o|--option) OPTION=$2; shift;;
        --) break;;
        *) usage;;
    esac
    shift
done


