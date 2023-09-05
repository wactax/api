#!/usr/bin/env bash

DIR=$(dirname "${BASH_SOURCE[0]}")

cd $DIR
set -e

env_sh() {
  cd $DIR/../conf/conn
  local i
  for i in $@; do
    set -o allexport
    source "$i".sh
    set +o allexport
  done

  cd $DIR
  unset -f env_sh
}

env_sh host kv gt redis mq pg mail clip nchan api
