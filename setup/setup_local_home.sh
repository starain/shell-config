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
echo 'Setting up bashrc'

echo "# BEGIN: $MAGIC_ANCHOR" >> ~/.bashrc
echo "export ZHANGYI_CONFIG_DIR=\"$CONFIG_DIR\"" >> ~/.bashrc
if [ -f "$CONFIG_DIR/bashrc/bashrc.sh" ]; then
    echo 'Adding bashrc config'

    echo '. "$ZHANGYI_CONFIG_DIR/bashrc/bashrc.sh"' >> ~/.bashrc
fi
echo "# END: $MAGIC_ANCHOR" >> ~/.bashrc

# Setup zshrc
echo 'Setting up zshrc'

echo "# BEGIN: $MAGIC_ANCHOR" >> ~/.zshrc
echo "export ZHANGYI_CONFIG_DIR=\"$CONFIG_DIR\"" >> ~/.zshrc
if [ -f "$CONFIG_DIR/zshrc/zshrc" ]; then
    echo 'Adding zshrc config'

    echo '. "$ZHANGYI_CONFIG_DIR/zshrc/zshrc"' >> ~/.zshrc
fi
echo "# END: $MAGIC_ANCHOR" >> ~/.zshrc

# Setup profile
if [ -f "$CONFIG_DIR/profile.sh" ]; then
    echo 'Setting up profile'

    echo "# BEGIN: $MAGIC_ANCHOR" >> ~/.profile
    echo '. "$ZHANGYI_CONFIG_DIR/profile.sh"' >> ~/.profile
    echo "# END: $MAGIC_ANCHOR" >> ~/.profile
fi

# Setup screen
if [ -f "$CONFIG_DIR/screenrc" ]; then
    echo 'Setting up screenrc'

    ln -sf "$CONFIG_DIR/screenrc" ~/.screenrc
fi

# Setup git
if [ -f "$CONFIG_DIR/git/gitignore" ]; then
    echo 'Setting up gitignore'

    ln -sf "$CONFIG_DIR/git/gitignore" ~/.gitignore
fi

if [ -f "$CONFIG_DIR/git/gitconfig" ]; then
    echo 'Setting up gitconfig'

    ln -sf "$CONFIG_DIR/git/gitconfig" ~/.gitconfig
fi

# Setup emacs
if [ -f "$CONFIG_DIR/emacs-config/setup/setup_local_home.sh" ]; then
    echo 'Setting up emacs'

    . "$CONFIG_DIR/emacs-config/setup/setup_local_home.sh"
fi

# Setup environment related stuff
# if [ "$ENV_DIR" != "$CONFIG_DIR" ]; then
#     if [ -f "$ENV_DIR/$MODULE_NAME/sbin/setup_local_home.sh" ]; then
#         . "$ENV_DIR/$MODULE_NAME/sbin/setup_local_home.sh"
#     fi
# fi
