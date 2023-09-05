#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*/*}
cd $DIR
set -ex

OPT=/opt/xxai.art

API=$OPT/api
mkdir -p $API
rsync --quiet --delete -av lib/ $API
cp package.json $API

if ! [ -x "$(command -v sd)" ]; then
  cargo install sd
fi

awk '{gsub(/\.\/lib/, ".")}1' package.json >$API/package.json

cd $OPT
if [ ! -e conf ]; then
  ln -s $(dirname $DIR)/conf .
fi

cd $API
pnpm i --product
cp $DIR/env.sh .
cp $DIR/sh/dist.run.sh run.sh
