#!/usr/bin/env bash

set -e

env_sh() {
  cd $(dirname "${BASH_SOURCE[0]}")/../conf/conn
  local i
  for i in $@; do
    set -o allexport
    source "$i".sh
    set +o allexport
  done

  unset -f env_sh
}

env_sh host kv gt redis mq pg mail clip nchan api
