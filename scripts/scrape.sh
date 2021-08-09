#!/bin/sh

# script to download all images of pokemon from pokemondb
while IFS= read -r line; do
  # printf '%s\n' "$line"
  # printf 'https://img.pokemondb.net/sprites/sword-shield/icon/%s.png\n' "$line"
  # echo 'https://img.pokemondb.net/sprites/sword-shield/icon/'$line'.png'
  wget 'https://img.pokemondb.net/sprites/sword-shield/icon/'$line'.png'

done < nameslist.txt
