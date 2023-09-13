#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

export NODE_PATH=$DIR/node_modules
exec ./lib/_/Http/main.js
