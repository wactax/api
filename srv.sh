#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
echo $$ >.run.pid

export NODE_PATH=$DIR/node_modules
exec ./lib/_/Http/main.js
