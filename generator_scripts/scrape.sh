#!/bin/sh

PATH_TO_NAMES='../nameslist.txt'

# script to download all images of pokemon from pokemondb
while IFS= read -r line; do
  wget 'https://img.pokemondb.net/sprites/sword-shield/icon/'$line'.png'

done < $PATH_TO_NAMES
