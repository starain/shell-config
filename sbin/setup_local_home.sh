#!/bin/bash

# Setup environment
CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_DIR="$CONFIG_DIR"
if [ $# -eq 1 ]
then
    ENV_DIR="$CONFIG_DIR/$1"
fi

# Setup bashrc
echo "# BEGIN: Setup by setup_local_home.sh" >> ~/.bashrc
echo "export ZHANGYI_CONFIG_DIR=\"$CONFIG_DIR\"" >> ~/.bashrc
echo "export ZHANGYI_ENV_DIR=\"$ENV_DIR\"" >> ~/.bashrc

echo 'if [ -f "$ZHANGYI_ENV_DIR/bashrc/bashrc.sh" ]; then' >> ~/.bashrc
echo '    . "$ZHANGYI_ENV_DIR/bashrc/bashrc.sh"' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
echo "# END: Setup by setup_local_home.sh" >> ~/.bashrc

# Setup profile
echo "# BEGIN: Setup by setup_local_home.sh" >> ~/.profile
echo 'if [ -f "$ZHANGYI_ENV_DIR/profile.sh" ]; then' >> ~/.profile
echo '    . "$ZHANGYI_ENV_DIR/profile.sh"' >> ~/.profile
echo 'fi' >> ~/.profile
echo "# END: Setup by setup_local_home.sh" >> ~/.profile

# Setup emacs
echo ";; BEGIN: Setup by setup_local_home.sh" >> ~/.emacs
echo "(load-file \"$ENV_DIR/emacs/start.el\")" >> ~/.emacs
echo ";; END: Setup by setup_local_home.sh" >> ~/.emacs

# Setup screen
if [ -f "$CONFIG_DIR/screenrc" ]; then
    ln -sf "$CONFIG_DIR/screenrc" ~/.screenrc
fi

# Setup environment related stuff
if [ -f "$ENV_DIR/sbin/setup_local_home.sh" ]; then
    . "$ENV_DIR/sbin/setup_local_home.sh"
fi
