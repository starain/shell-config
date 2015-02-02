#!/bin/bash

# Setup environment
if [ $# -lt 1 ]
then
    echo "Usage ${BASH_SOURCE[0]} target_config_dir [environment_sub_dir]"
    exit
fi

SOURCE_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CONFIG_DIR="$1"
ENV_DIR="$CONFIG_DIR"
if [ $# -eq 2 ]
then
    ENV_DIR_NAME="$2"
    ENV_DIR="$CONFIG_DIR/$ENV_DIR_NAME"
fi

if [ "$SOURCE_CONFIG_DIR" != "$CONFIG_DIR" ]
then
  mkdir -p $CONFIG_DIR

  for sub_dir in $(ls $SOURCE_CONFIG_DIR)
  do
    cd $CONFIG_DIR
    git clone $SOURCE_CONFIG_DIR/$sub_dir
    if [ "$sub_dir" != "$ENV_DIR_NAME" ]
    then
      cd $CONFIG_DIR/$sub_dir
      git config user.email "starain.zhang@gmail.com"
    fi
  done
fi

# Setup bashrc
echo "# BEGIN: Setup by setup_local_home.sh" >> ~/.bashrc
echo "export ZHANGYI_CONFIG_DIR=\"$CONFIG_DIR\"" >> ~/.bashrc
echo "export ZHANGYI_ENV_DIR=\"$ENV_DIR\"" >> ~/.bashrc

echo 'if [ -f "$ZHANGYI_ENV_DIR/shell-config/bashrc/bashrc.sh" ]; then' >> ~/.bashrc
echo '    . "$ZHANGYI_ENV_DIR/shell-config/bashrc/bashrc.sh"' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
echo "# END: Setup by setup_local_home.sh" >> ~/.bashrc

echo "# BEGIN: Setup by setup_local_home.sh" >> ~/.zshrc
echo "export ZHANGYI_CONFIG_DIR=\"$CONFIG_DIR\"" >> ~/.zshrc
echo "export ZHANGYI_ENV_DIR=\"$ENV_DIR\"" >> ~/.zshrc

echo 'if [ -f "$ZHANGYI_ENV_DIR/shell-config/zshrc/zshrc" ]; then' >> ~/.zshrc
echo '    . "$ZHANGYI_ENV_DIR/shell-config/zshrc/zshrc"' >> ~/.zshrc
echo 'fi' >> ~/.zshrc
echo "# END: Setup by setup_local_home.sh" >> ~/.zshrc

# Setup profile
echo "# BEGIN: Setup by setup_local_home.sh" >> ~/.profile
echo 'if [ -f "$ZHANGYI_ENV_DIR/shell-config/profile.sh" ]; then' >> ~/.profile
echo '    . "$ZHANGYI_ENV_DIR/shell-config/profile.sh"' >> ~/.profile
echo 'fi' >> ~/.profile
echo "# END: Setup by setup_local_home.sh" >> ~/.profile

# Setup emacs
echo ";; BEGIN: Setup by setup_local_home.sh" >> ~/.emacs
echo "(load-file \"$ENV_DIR/emacs-config/start.el\")" >> ~/.emacs
echo ";; END: Setup by setup_local_home.sh" >> ~/.emacs

# Setup screen
if [ -f "$CONFIG_DIR/shell-config/screenrc" ]; then
    ln -sf "$CONFIG_DIR/shell-config/screenrc" ~/.screenrc
fi

# Setup git
if [ -f "$CONFIG_DIR/shell-config/gitignore" ]; then
    ln -sf "$CONFIG_DIR/shell-config/gitignore" ~/.gitignore
fi

# Setup environment related stuff
if [ "$ENV_DIR" != "$CONFIG_DIR" ]; then
    if [ -f "$ENV_DIR/shell-config/sbin/setup_local_home.sh" ]; then
        . "$ENV_DIR/shell-config/sbin/setup_local_home.sh"
    fi
fi
