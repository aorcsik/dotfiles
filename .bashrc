# ALIASES
test -s ~/.alias && . ~/.alias || true

# vim
# alias vim="vim -u ~/.dotfiles/.vimrc --cmd 'set rtp^=~/.dotfiles/.vim'"

# ls
alias ls="ls --color=auto"
alias ll="ls -la --color=auto"

Color_Off="\[\033[0m\]"       # Text Reset
Blue1="\[\033[38;5;75m\]"
Blue2="\[\033[38;5;32m\]"
Orange1="\[\033[38;5;214m\]"
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green

. ~/.dotfiles/prompt.sh
