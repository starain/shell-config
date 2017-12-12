#!/bin/bash

alias tw='tmux new -s work || tmux a -t work'
alias ls='ls --color=auto'
alias l='ls'
alias emacsclient='TERM=xterm-256color emacsclient'
alias emacs='TERM=xterm-256color emacs'
alias e='emacsclient -t'
alias es="emacs -nw --daemon"
