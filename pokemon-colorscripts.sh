#!/bin/sh


PROGRAM=$(readlink -f "$0")
PROGRAM_DIR=$(dirname "$PROGRAM")
# directory where all the art files exist
POKEART_DIR="$PROGRAM_DIR/colorscripts"
# formatting for the help strings
fmt_help="  %-20s\t%-54s\n"


_help(){
    #Function that prints out the help text

    echo "Description: CLI utility to print out unicode image of a pokemon in your shell"
    echo ""
    echo "Usage: pokemon-colorscripts [OPTION] [POKEMON NAME]"
    printf "${fmt_help}" \
        "-h, --help, help" "Print this help." \
        "-l, --list, list" "Print list of all pokemon"\
        "-r, --random, random" "Show a random pokemon"\
        "-n, --name" "Select pokemon by name. Generally spelled like in the games.
                        a few exceptions are nidoran-f,nidoran-m,mr-mime,farfetchd,flabebe
                        type-null etc. Perhaps grep the output of --list if in
                        doubt"
    echo "Example: 'pokemon-colorscripts --name pikachu'"
}

_show_random_pokemon(){
    #selecting a random art file from the whole set

    # total number of art files present
    NUM_ART=$(ls -1 "$POKEART_DIR"|wc -l)
    # getting a random index from 0-NUM_ART. (using shuf instead of $RANDOM for POSIX compliance)
    random_index=$(shuf -i 1-$NUM_ART -n 1)
    random_pokemon=$(sed $random_index'q;d' "$PROGRAM_DIR/nameslist.txt")
    echo $random_pokemon

    # print out the pokemon art for the pokemon
    cat "$POKEART_DIR/$random_pokemon.txt"
}

_show_pokemon_by_name(){
    pokemon_name=$1
    echo $pokemon_name
    # Error handling. Can't think of a better way to do it
    cat "$POKEART_DIR/$pokemon_name.txt" 2>/dev/null || echo "Invalid pokemon"
}

_list_pokemon_names(){
    cat "$PROGRAM_DIR/nameslist.txt"|less
}

# Handling command line arguments
case "$#" in
    0)
        # display help if no arguments are given
        _help
        ;;
    1)
        # Check flag and show appropriate output
        case $1 in
            -h | --help | help)
                _help
                ;;
            -r | --random | random)
                _show_random_pokemon
                ;;
            -l | --list | list)
                _list_pokemon_names
                ;;
            *)
                echo "Input error."
                exit 1
                ;;
        esac
        ;;

    2)
        if [ "$1" = '-n' ]||[ "$1" = '--name' ]||[ "$1" = 'name' ]; then
            _show_pokemon_by_name "$2"
        else
            echo "Input error"
            exit 1
        fi
        ;;
    *)
        echo "Input error, too many arguments."
        exit 1
        ;;
esac
