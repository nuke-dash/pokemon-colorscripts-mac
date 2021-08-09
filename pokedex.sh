#!/bin/sh

# directory where all the art files exist
POKEART_DIR='./pokeart'
# total number of art files present
NUM_ART=$(ls -1 $POKEART_DIR|wc -l)

#selecting a random art file from the whole set
random_index=$(($RANDOM%$NUM_ART))
random_pokemon=$(sed $random_index'q;d' './scrape/nameslist.txt')
pokemon_name=$random_pokemon

# printing out a pokemon
echo $pokemon_name
cat $POKEART_DIR'/'$pokemon_name'.txt'
