#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

export NODE_PATH=$DIR/node_modules:$NODE_PATH

cd $DIR
./init.pkg.sh

cd $DIR/src/_/Pg/init

counter=0
max_retries=99

while [ $counter -lt $max_retries ]; do
  set +e
  ./uint.coffee
  set -e

  if [ $? -eq 0 ]; then
    break
  else
    echo "$counter / $max_retries : failed, sleep 3s"
    sleep 3
    counter=$((counter + 1))
  fi
done

cd $DIR/src/_/Redis/init
./merge.coffee

cd $DIR
bunx cep -c src -o lib >/dev/null
./lib/_/Init/gen/build.js
./run.sh ./lib/_/Init/main.js
