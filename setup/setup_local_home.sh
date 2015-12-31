#!/bin/bash

# Setup environment
# if [ $# -gt 1 ]
# then
#     echo "Usage setup_local_home.sh [config_dir]"
#     echo "Default config directory is $HOME/.config.zhangyi"
#     exit
# fi

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Checkout and update all submodules
cd $CONFIG_DIR
git submodule update --init --recursive

MAGIC_ANCHOR="Setup by setup_local_home.sh"

# Setup bashrc
for f in "bashrc" "zshrc"
do
    echo "Setting up $f"

    echo "# BEGIN: $MAGIC_ANCHOR" >> ~/.$f
    echo "export ZHANGYI_CONFIG_DIR=\"$CONFIG_DIR\"" >> ~/.$f
    if [ -f "$CONFIG_DIR/$f/$f" ]; then
        echo "Adding $f config"
        echo '. "$ZHANGYI_CONFIG_DIR/$f/$f"' >> ~/.$f
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

for f in "screenrc" "gitignore" "gitconfig"
do
    if [ -f "$CONFIG_DIR/$f" ]; then
        echo "Setting up $f"

        ln -s "$CONFIG_DIR/$f" ~/.$f
    fi
done

# Setup environment related stuff
# if [ "$ENV_DIR" != "$CONFIG_DIR" ]; then
#     if [ -f "$ENV_DIR/$MODULE_NAME/sbin/setup_local_home.sh" ]; then
#         . "$ENV_DIR/$MODULE_NAME/sbin/setup_local_home.sh"
#     fi
# fi
