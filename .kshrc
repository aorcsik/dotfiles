#!/bin/ksh

set -o emacs
alias __A=`echo "\020"`     # up arrow = ^p = back a command
alias __B=`echo "\016"`     # down arrow = ^n = down a command
alias __C=`echo "\006"`     # right arrow = ^f = forward a character
alias __D=`echo "\002"`     # left arrow = ^b = back a character
alias __H=`echo "\001"`     # home = ^a = start of line
alias __Y=`echo "\005"`     # end = ^e = end of line

# ALIASES
test -s ~/.alias && . ~/.alias || true

alias logout=exit

Color_Off="\033[0m"       # Text Reset
Blue1="\033[38;5;75m"
Blue2="\033[38;5;32m"
Orange1="\033[38;5;214m"
IRed="\033[0;91m"         # Red
IGreen="\033[0;92m"       # Green

. ~/.dotfiles/prompt.sh
