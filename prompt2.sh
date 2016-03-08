#!/bin/sh

Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"
Hostname="\h"

. ~/.dotfiles/colors.sh

CheckMarkSymbol="✓"
BallotXSymbol="✗"

function __prompt_command {
export PS1='$(if [ $? != 0 ]; then
    echo "'$IRed'$BallotXSymbol'$Color_Off'"
else
    echo "'$IGreen'$CheckMarkSymbol'$Color_Off'"
fi) '$Blue1'['$Time12h']'$Color_Off' '\
$Orange1$Hostname$Color_Off' '\
$Blue2$PathShort$Color_Off' '\
$Orange1'\$'$Color_Off' '
}

PROMPT_COMMAND=__prompt_command
