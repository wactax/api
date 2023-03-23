#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*/*}
cd $DIR
set -ex

api=../ops/docker/api/src
mkdir -p $api
rsync --quiet --delete -av lib/ $api
cp package.json $api

if ! [ -x "$(command -v sd)" ]; then
  cargo install sd
fi

awk '{gsub(/\.\/lib/, ".")}1' package.json >$api/package.json
