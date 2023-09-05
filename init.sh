#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

rm -rf $HOME/.cache/pg/uint

if ! [ -x "$(command -v cargo)" ]; then
  PATH_add $HOME/.cargo/bin
  if ! [ -x "$(command -v cargo)" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
fi

if ! [ -x "$(command -v sd)" ]; then
  cargo install sd
fi

export NODE_PATH=$DIR/node_modules:$NODE_PATH

cd $DIR
./init.pkg.sh

cd $DIR/src/_/Pg/init

counter=0
max_retries=99

set +e
while [ $counter -lt $max_retries ]; do
  if [ $? -eq 0 ]; then
    break
  else
    echo -e "\n$counter / $max_retries : failed, sleep 3s\n"
    sleep 3
    counter=$((counter + 1))
  fi
done
set -e

cd $DIR/src/_/Redis/init
./merge.coffee

cd $DIR
bunx cep -c src -o lib >/dev/null
./lib/_/Init/gen/build.js
./run.sh ./lib/_/Init/main.js
