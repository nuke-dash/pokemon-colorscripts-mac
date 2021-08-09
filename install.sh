#!/bin/sh

# A basic install script for pokemon-colorscripts

# deleting directory if it already exists
rm -rf /opt/pokemon-colorscripts || return 1

# making the necessary folder structure
mkdir -p /opt/pokemon-colorscripts || return 1

# moving all the files to appropriate locations
cp -rf colorscripts /opt/pokemon-colorscripts
cp pokemon-colorscripts.sh /opt/pokemon-colorscripts/pokemon-colorscripts
cp nameslist.txt /opt/pokemon-colorscripts

# create symlink in usr/bin
rm -rf /usr/bin/pokemon-colorscripts || return 1
ln -s /opt/pokemon-colorscripts/pokemon-colorscripts /usr/bin/pokemon-colorscripts

