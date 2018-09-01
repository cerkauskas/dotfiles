#!/bin/bash

MAIN_DIR="`dirname \"$0\"`"            # relative
MAIN_DIR="`( cd \"$MAIN_DIR\" && pwd )`"  # absolutized and normalized
if [ -z "$MAIN_DIR" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

ln -s "$MAIN_DIR/vim/.vimrc" ~/.vimrc
