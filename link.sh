#!/usr/bin/env bash
source dotfiles.sh

OVERWRITE=1

while getopts hf flag
do
    case "${flag}" in
	h) print_help;;
	n) OVERWRITE=0;;
    esac
done

count=${#links[@]}
if [ $(expr $count % 2) != 0 ]; then
    exit "There were an odd number of entries in links; it must contain
          pairs of source, destination filenames"
fi

function link() {
    if [[ -L "$2" && -e "$2" ]]; then
        proceed=$OVERWRITE 
    elif [[ -e "$2" ]]; then
        echo "Skipping $2 because it already exists and is not a symlink"
        proceed=0
    else
        proceed=1
    fi

    if [ $proceed ]; then
        full_source=$(realpath "$1")
        full_dest=$(realpath -s "$2")
        dest_dir=$(dirname "$full_dest")
        if [ -e "$full_dest" ]; then
            echo -e "\e[1;31m[Overwriting]\e[0m Linking $1 to $2"
            rm "$full_dest"
        else
            echo "Linking $1 to $2"
        fi
        if [ ! -d "$dest_dir" ]; then
            mkdir -p "$dest_dir"
        fi
        ln -s "$full_source" "$full_dest"
    fi
}

function print_help() {
    echo "$0 [-f] [-h]: Link all dotfiles in a directory to their destinations"
    echo "-n\tDon't overwrite existing links (this script never overwrites"
         "existing dotfiles"
    echo "-h\tPrint this help message"
}

function link_all() {
    index=0
    while [ "$index" -lt "$count" ]
    do
	source=${links[$index]}
	dest=${links[$index + 1]}
	let "index = $index + 2"

	link "$source" "${dest/#\~/$HOME}"
    done
}

link_all
