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
cd $CONFIG_DIR/$MODULE_NAME
git submodule update --init --recursive
cd $CONFIG_DIR

MAGIC_ANCHOR="Setup by setup_local_home.sh"

# Setup bashrc
echo "# BEGIN: $MAGIC_ANCHOR" >> ~/.bashrc
echo "export ZHANGYI_CONFIG_DIR=\"$CONFIG_DIR\"" >> ~/.bashrc
echo "export ZHANGYI_ENV_DIR=\"$ENV_DIR\"" >> ~/.bashrc

echo 'if [ -f "$ZHANGYI_ENV_DIR/'"$MODULE_NAME"'/bashrc/bashrc.sh" ]; then' >> ~/.bashrc
echo '    . "$ZHANGYI_ENV_DIR/'"$MODULE_NAME"'/bashrc/bashrc.sh"' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
echo "# END: $MAGIC_ANCHOR" >> ~/.bashrc

# Setup zshrc
echo "# BEGIN: $MAGIC_ANCHOR" >> ~/.zshrc
echo "export ZHANGYI_CONFIG_DIR=\"$CONFIG_DIR\"" >> ~/.zshrc
echo "export ZHANGYI_ENV_DIR=\"$ENV_DIR\"" >> ~/.zshrc

echo 'if [ -f "$ZHANGYI_ENV_DIR/'"$MODULE_NAME"'/zshrc/zshrc" ]; then' >> ~/.zshrc
echo '    . "$ZHANGYI_ENV_DIR/'"$MODULE_NAME"'/zshrc/zshrc"' >> ~/.zshrc
echo 'fi' >> ~/.zshrc
echo "# END: $MAGIC_ANCHOR" >> ~/.zshrc

# Setup profile
echo "# BEGIN: $MAGIC_ANCHOR" >> ~/.profile
echo 'if [ -f "$ZHANGYI_ENV_DIR/'"$MODULE_NAME"'/profile.sh" ]; then' >> ~/.profile
echo '    . "$ZHANGYI_ENV_DIR/'"$MODULE_NAME"'/profile.sh"' >> ~/.profile
echo 'fi' >> ~/.profile
echo "# END: $MAGIC_ANCHOR" >> ~/.profile

# Setup screen
if [ -f "$CONFIG_DIR/$MODULE_NAME/screenrc" ]; then
    ln -sf "$CONFIG_DIR/$MODULE_NAME/screenrc" ~/.screenrc
fi

# Setup git
if [ -f "$CONFIG_DIR/$MODULE_NAME/git/gitignore" ]; then
    ln -sf "$CONFIG_DIR/$MODULE_NAME/git/gitignore" ~/.gitignore
fi

if [ -f "$CONFIG_DIR/$MODULE_NAME/git/gitconfig" ]; then
    ln -sf "$CONFIG_DIR/$MODULE_NAME/git/gitconfig" ~/.gitconfig
fi

# Setup emacs
if [ -f "$CONFIG_DIR/$MODULE_NAME/emacs-config/setup/setup_local_home.sh" ]; then
    . "$CONFIG_DIR/$MODULE_NAME/emacs-config/setup/setup_local_home.sh"
fi

# Setup environment related stuff
if [ "$ENV_DIR" != "$CONFIG_DIR" ]; then
    if [ -f "$ENV_DIR/$MODULE_NAME/sbin/setup_local_home.sh" ]; then
        . "$ENV_DIR/$MODULE_NAME/sbin/setup_local_home.sh"
    fi
fi
