#!/bin/bash

# Setup environment
if [ $# -lt 0 ]
then
    echo "Usage ${BASH_SOURCE[0]} [environment_sub_dir]"
    exit
fi

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
ENV_DIR="$CONFIG_DIR"
if [ $# -eq 1 ]
then
    ENV_DIR_NAME="$1"
    ENV_DIR="$CONFIG_DIR/$ENV_DIR_NAME"
fi

MODULE_NAME="shell-config"
MAGIC_ANCHOR="Setup by setup_local_home.sh"

TMP_FILE=$(mktemp)

for f in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile" "$HOME/.emacs"
do
    sed "/$MAGIC_ANCHOR/,/$MAGIC_ANCHOR/d" $f > $TMP_FILE && mv $TMP_FILE $f
done

if [ -f "$CONFIG_DIR/${MODULE_NAME}/screenrc" ]; then
    rm ~/.screenrc
fi

if [ -f "$CONFIG_DIR/${MODULE_NAME}/git/gitignore" ]; then
    rm ~/.gitignore
fi

if [ -f "$CONFIG_DIR/${MODULE_NAME}/git/gitconfig" ]; then
    rm ~/.gitconfig
fi
