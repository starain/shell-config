#!/bin/bash

if [ -f "$ZHANGYI_CONFIG_DIR/shell/bashrc/alias.sh" ]; then
    . "$ZHANGYI_CONFIG_DIR/shell/bashrc/alias.sh"
fi

export EDITOR='emacsclient -a ""'

