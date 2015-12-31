#!/bin/bash

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MAGIC_ANCHOR="Setup by setup_local_home.sh"

TMP_FILE=$(mktemp)

for f in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile"
do
    echo "Removing config from $f"
    sed "/$MAGIC_ANCHOR/,/$MAGIC_ANCHOR/d" $f > $TMP_FILE && mv $TMP_FILE $f
done

for f in "screenrc" "gitignore" "gitconfig"
do
    if [ -f "$CONFIG_DIR/$f" ]; then
        echo "Removing file $f"
        find ~/.$f -type l -delete
    fi
done
