#!/bin/bash

if [ -f "$ZHANGYI_CONFIG_DIR/shell-config/bashrc/alias.sh" ]; then
    . "$ZHANGYI_CONFIG_DIR/shell-config/bashrc/alias.sh"
fi

export EDITOR='emacsclient -a ""'
export TERM=xterm-256color
