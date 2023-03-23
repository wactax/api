#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

killpid() {
  if [ -f $1 ]; then
    read pid <$1
    echo $pid
    ps -p $pid >/dev/null
    r=$?
    if [ $r -eq 0 ]; then
      echo "kill $pid"
      kill -9 $pid
      sleep 1
    fi
    rm -rf $pid
  fi
}

killpid .dev.pid
killpid sh/.dev.pid
killpid .run.pid

set -ex

./pkg.coffee

./build.sh
./lib/_/Init/conf.js
