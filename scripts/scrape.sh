#!/bin/sh

# script to download all images of pokemon from pokemondb
while IFS= read -r line; do
  wget 'https://img.pokemondb.net/sprites/sword-shield/icon/'$line'.png'

done < nameslist.txt
