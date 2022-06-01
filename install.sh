#!/usr/bin/env bash
git submodule update

function msg() {
    echo -e "\e[0;34m$@\e[0m"
}

msg Installing vim-plug
VIM_AUTOLOAD_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload
mkdir -p $VIM_AUTOLOAD_DIR
cp vim-plug/plug.vim "$VIM_AUTOLOAD_DIR"/plug.vim

echo 
msg Linking dotfiles
bash link.sh "$@"

echo 
msg Installing vim-plug plugins
nvim -c "PlugInstall" \
     -c "qa"
