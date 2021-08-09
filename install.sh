#!/bin/sh

# A basic install script for pokemon-colorscripts

INSTALL_DIR='/usr/local/opt'
BIN_DIR='/usr/local/bin'

# deleting directory if it already exists
rm -rf $INSTALL_DIR/pokemon-colorscripts || return 1

# making the necessary folder structure
mkdir -p $INSTALL_DIR/pokemon-colorscripts || return 1

# moving all the files to appropriate locations
cp -rf colorscripts $INSTALL_DIR/pokemon-colorscripts
cp pokemon-colorscripts.sh $INSTALL_DIR/pokemon-colorscripts/pokemon-colorscripts
cp nameslist.txt $INSTALL_DIR/pokemon-colorscripts

# create symlink in usr/bin
rm -rf $BIN_DIR/pokemon-colorscripts || return 1
ln -s $INSTALL_DIR/pokemon-colorscripts/pokemon-colorscripts $BIN_DIR/pokemon-colorscripts

