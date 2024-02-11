#!/bin/bash

set -x 

get_nvim() {
  rm -rf nvim
  mkdir nvim
  cp -r ~/.config/nvim/* nvim/
  echo "nvim copied"
}

get_bashrc() {
  cp ~/.bashrc bashrc
  echo "bashrc copied"
}

if $1 == "editor"; then
  get_nvim
elif $1 == "bashrc"; then
  get_bashrc
else
  echo "Invalid argument"
fi
