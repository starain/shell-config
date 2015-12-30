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

# Setup bashrc
echo "# BEGIN: Setup by setup_local_home.sh" >> ~/.bashrc
echo "export ZHANGYI_CONFIG_DIR=\"$CONFIG_DIR\"" >> ~/.bashrc
echo "export ZHANGYI_ENV_DIR=\"$ENV_DIR\"" >> ~/.bashrc

echo 'if [ -f "$ZHANGYI_ENV_DIR/'"${MODULE_NAME}"'/bashrc/bashrc.sh" ]; then' >> ~/.bashrc
echo '    . "$ZHANGYI_ENV_DIR/'"${MODULE_NAME}"'/bashrc/bashrc.sh"' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
echo "# END: Setup by setup_local_home.sh" >> ~/.bashrc

# Setup zshrc
echo "# BEGIN: Setup by setup_local_home.sh" >> ~/.zshrc
echo "export ZHANGYI_CONFIG_DIR=\"$CONFIG_DIR\"" >> ~/.zshrc
echo "export ZHANGYI_ENV_DIR=\"$ENV_DIR\"" >> ~/.zshrc

echo 'if [ -f "$ZHANGYI_ENV_DIR/'"${MODULE_NAME}"'/zshrc/zshrc" ]; then' >> ~/.zshrc
echo '    . "$ZHANGYI_ENV_DIR/'"${MODULE_NAME}"'/zshrc/zshrc"' >> ~/.zshrc
echo 'fi' >> ~/.zshrc
echo "# END: Setup by setup_local_home.sh" >> ~/.zshrc

# Setup profile
echo "# BEGIN: Setup by setup_local_home.sh" >> ~/.profile
echo 'if [ -f "$ZHANGYI_ENV_DIR/'"${MODULE_NAME}"'/profile.sh" ]; then' >> ~/.profile
echo '    . "$ZHANGYI_ENV_DIR/'"${MODULE_NAME}"'/profile.sh"' >> ~/.profile
echo 'fi' >> ~/.profile
echo "# END: Setup by setup_local_home.sh" >> ~/.profile

# Setup emacs
echo ";; BEGIN: Setup by setup_local_home.sh" >> ~/.emacs
echo "(load-file \"$ENV_DIR/${MODULE_NAME}/emacs-config/start.el\")" >> ~/.emacs
echo ";; END: Setup by setup_local_home.sh" >> ~/.emacs

# Setup screen
if [ -f "$CONFIG_DIR/${MODULE_NAME}/screenrc" ]; then
    ln -sf "$CONFIG_DIR/${MODULE_NAME}/screenrc" ~/.screenrc
fi

# Setup git
if [ -f "$CONFIG_DIR/${MODULE_NAME}/git/gitignore" ]; then
    ln -sf "$CONFIG_DIR/${MODULE_NAME}/git/gitignore" ~/git/.gitignore
fi

if [ -f "$CONFIG_DIR/${MODULE_NAME}/git/gitconfig" ]; then
    ln -sf "$CONFIG_DIR/${MODULE_NAME}/git/gitconfig" ~/git/.gitconfig
fi

# Setup environment related stuff
if [ "$ENV_DIR" != "$CONFIG_DIR" ]; then
    if [ -f "$ENV_DIR/${MODULE_NAME}/sbin/setup_local_home.sh" ]; then
        . "$ENV_DIR/${MODULE_NAME}/sbin/setup_local_home.sh"
    fi
fi
