#!/bin/sh

CheckMarkSymbol="✓"
BallotXSymbol="✗"

function git_branch_prompt {
    git branch | grep "*" | sed 's/\* //'
}

function git_branch_flag {
    echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
    if [ $? != 0 ]; then \
        echo "*"
    fi
}

PS1='$(echo $(if [ $? != 0 ]; then
    echo "'$IRed'$BallotXSymbol'$Color_Off'"
else
    echo "'$IGreen'$CheckMarkSymbol'$Color_Off'"
fi) \
"'$Blue1'["$(date +"%T")"]'$Color_Off'" \
"'$Orange1'"$(hostname -s)"'$Color_Off'" \
"'$Blue2'"$(pwd | sed "s,^$HOME,~,")"'$Color_Off'" \
$(git branch > /dev/null 2>&1; \
if [ $? == 0 ]; then
    echo "'$Blue1'($(git_branch_prompt)'$Orange1'$(git_branch_flag)'$Blue1')"
fi) "'$Orange1'\$'$Color_Off' ")'
