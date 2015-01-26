#!/bin/bash

if [ -f "$ZHANGYI_CONFIG_DIR/shell/zshrc/zshrc" ]; then
    . "$ZHANGYI_CONFIG_DIR/shell/zshrc/zshrc"
fi

if [ -f "$ZHANGYI_CONFIG_DIR/shell/bashrc/alias.sh" ]; then
    . "$ZHANGYI_CONFIG_DIR/shell/bashrc/alias.sh"
fi

export EDITOR='emacsclient -a ""'
export TERM=xterm-256color
