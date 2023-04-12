#!/bin/sh
#
path=$1

cp ./Python.gitignore ${path}/.gitignore
python3 -m venv ${path}
cd ${path}
git init

