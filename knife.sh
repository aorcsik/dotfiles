#!/bin/sh

ksn() {
    knife search node "name:$1-*" | grep "$1-i-[0-9a-f]\+" | sed -e 's:.*\(i-[0-9a-f]\{8\}\).*:\1:' | sort | uniq
}


get_cookbook() {
    if [ -z $1 ]; then
        COOKBOOK=`pwd | grep 'cookbooks/' | sed 's/^.*\/cookbooks\/\([^/]*\).*$/\1/'`
    else
        COOKBOOK=$1
    fi
    if [ -z $COOKBOOK ] || [ "$COOKBOOK" = "" ]; then
        echo "Cannot find cookbook!" >&2
        return 1
    fi
    echo $COOKBOOK
}

cd_chef_root() {
    IN_CHEF_ROOT=`ls | grep '^cookbooks$'`
    while [ -z $IN_CHEF_ROOT ] && [ `pwd` != "/" ]; do
        cd ..
        IN_CHEF_ROOT=`ls | grep "^cookbooks$"`
    done
    if [ -z $IN_CHEF_ROOT ]; then
        cd $ACTUAL
        echo "Cannot find chef cookbooks folder!" >&2
        return 1
    fi
}

ksb() {
    ACTUAL=`pwd`

    COOKBOOK=`get_cookbook $1`
    if [ $? -ne 0 ]; then
        return 1
    fi

    cd_chef_root
    if [ $? -ne 0 ]; then;
        return 2
    fi

    knife spork bump $COOKBOOK

    cd $ACTUAL
}

ksu() {
    ACTUAL=`pwd`

    COOKBOOK=`get_cookbook $1`
    if [ $? -ne 0 ]; then
        return 1
    fi

    cd_chef_root
    if [ $? -ne 0 ]; then;
        return 2
    fi

    knife spork upload $COOKBOOK

    cd $ACTUAL
}