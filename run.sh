#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
echo $$ > .run.pid

if [ -n "$1" ]; then
  cmd=$1
else
  cmd=./lib/_/Http/main.js
fi
timeout=30
while [ ! -f "$cmd" ]; do
  if [ "$timeout" == 0 ]; then
    echo "ERROR: $cmd NOT EXIST"
    exit 1
  fi
  sleep 1
  ((timeout--))
done

exec $cmd
