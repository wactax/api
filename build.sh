#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

if [ ! -d $DIR/node_modules ]; then
  if ! [ -x "$(command -v pnpm)" ]; then
    npm install -g pnpm
  fi
  NODE_ENV=dev pnpm i
fi

rm -rf lib

bunx cep -c src -o lib >/dev/null

cd lib

set +x
echo 'TODO : replace DEBUG = false'
# for file in $(fd -I --extension js); do
#   sd 'DEBUG\s*=\s*true' 'DEBUG = false' "$file"
# done
set -x

cd $DIR

GEN=$DIR/lib/_/Init/gen

$GEN/build.js
$GEN/gen.js
