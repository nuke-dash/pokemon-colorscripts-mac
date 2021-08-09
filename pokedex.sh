#!/bin/sh

# directory where all the art files exist
POKEART_DIR='./pokeart'
POKELIST_DIR='./scrape'
# formatting for the help strings
fmt_help="  %-20s\t%-54s\n"


function _help(){
    #Function that prints out the help text

    echo "Description: CLI utility to print out unicode image of a pokemon in your shell"
    echo ""
    echo "Usage: pokedex [OPTION] [POKEMON NAME]"
    printf "${fmt_help}" \
        "-h, --help, help" "Print this help." \
        "-r, --random, random" "Show a random pokemon"
}

function _show_random_pokemon(){
    #selecting a random art file from the whole set

    # total number of art files present
    NUM_ART=$(ls -1 $POKEART_DIR|wc -l)
    # getting a random index from 0-NUM_ART
    random_index=$(($RANDOM%$NUM_ART))
    random_pokemon=$(sed $random_index'q;d' $POKELIST_DIR'/nameslist.txt')
    echo $random_pokemon

    # print out the pokemon art for the pokemon
    cat $POKEART_DIR'/'$random_pokemon'.txt'
}
# Handling command line arguments
case "$#" in
    0)
        # display help if no arguments are given
        _help
        ;;
    1)
        case "$1" in
            -h | --help | help)
                _help
                ;;
            -r | --random | random)
                _show_random_pokemon
                ;;
            *)
                echo "Input error."
                exit 1
                ;;
        esac
        ;;
esac
