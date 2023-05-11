#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))

cd $DIR
echo $$ >.dev.pid

rm -rf lib
set -ex

bunx cep -c ./sh/rsync.coffee
rsync_js=$DIR/sh/rsync.js

exec bunx concurrently \
  --kill-others \
  --raw \
  "$rsync_js" \
  "./sh/dev.sh"
