declare -a links
links=(
    ".bashrc" "~/.bashrc"
)

count=${#links[@]}
if [ $(expr $count % 2) != 0 ]; then
    exit "There were an odd number of entries in links; it must contain
          pairs of source, destination filenames"
fi

function link() {
    if [ -f "$2" ]; then
        echo "$2 already exists; skipping"
    elif [ -L "$2" ]; then
        echo "$1 already linked to $2"
    else
        echo "Linking $1 to $2"
	full_source=$(realpath "$1")
	full_dest=$(realpath -s "$2")
        ln -s $full_source $full_dest
    fi
}

function print_help() {
    echo "$0 [-f] [-h]: Link all dotfiles in a directory to their destinations"
    echo "-f\tIf the dotfile already exists at destination, overwrite it"
    echo "-h\tPrint this help message"
}

function clean_links() {
    index=0
    while [ "$index" -lt "$count" ]
    do
	source=${links[$index]}
	dest=${links[$index + 1]}
	let "index = $index + 2"

	if [ -L $source ]; then
	    echo "Overwriting $source"
	    rm $(realpath -s $source)
	fi
    done
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

while getopts hf flag
do
    case "${flag}" in
	h) print_help;;
	f) clean_links;;
    esac
done

link_all
