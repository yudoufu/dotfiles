#!/bin/sh

usage() {
    echo ""
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


