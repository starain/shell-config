#!/bin/bash

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MAGIC_ANCHOR="Setup by setup_shell.sh"

LINK_FILE="screenrc gitignore gitconfig tmux.conf"

install() {
    # Checkout and update all submodules
    cd $CONFIG_DIR
    git submodule update --init --recursive

    # Setup bashrc and zshrc
    for f in "bashrc" "zshrc"
    do
        echo "Setting up $f"

        echo "# BEGIN: $MAGIC_ANCHOR" >> ~/.$f
        echo "export ZHANGYI_CONFIG_DIR=\"$CONFIG_DIR\"" >> ~/.$f
        if [ -f "$CONFIG_DIR/$f/$f" ]; then
            echo "Adding $f config"
            echo '. "$ZHANGYI_CONFIG_DIR'"/$f/$f"'"' >> ~/.$f
        fi
        echo "# END: $MAGIC_ANCHOR" >> ~/.$f
    done

    # Setup profile
    if [ -f "$CONFIG_DIR/profile" ]; then
        echo 'Setting up profile'

        echo "# BEGIN: $MAGIC_ANCHOR" >> ~/.profile
        echo '. "$ZHANGYI_CONFIG_DIR/profile"' >> ~/.profile
        echo "# END: $MAGIC_ANCHOR" >> ~/.profile
    fi

    for f in $(echo $LINK_FILE)
    do
        if [ -f "$CONFIG_DIR/$f" ]; then
            echo "Setting up $f"

            ln -s "$CONFIG_DIR/$f" ~/.$f
        fi
    done
}

uninstall() {
    TMP_FILE=$(mktemp)
    for f in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile"
    do
        echo "Removing config from $f"
        sed "/$MAGIC_ANCHOR/,/$MAGIC_ANCHOR/d" $f > $TMP_FILE && mv $TMP_FILE $f
    done

    for f in $(echo $LINK_FILE)
    do
        if [ -f "$CONFIG_DIR/$f" ]; then
            echo "Removing file $f"
            find ~/.$f -type l -delete
        fi
    done
}

case "$1" in
'install')
    install
    ;;
'uninstall')
    uninstall
    ;;
*)
    echo "Usage ${BASH_SOURCE[0]} install/uninstall"
    exit
    ;;
esac
