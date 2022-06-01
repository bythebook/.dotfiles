declare -a links
links=(
    "bashrc" "~/.bashrc"
    "init.vim" "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim/init.vim
)
