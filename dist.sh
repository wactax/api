#!/usr/bin/env bash

_DIR=$(
  cd "$(dirname "$0")"
  pwd
)

cd $_DIR

set -ex
./build.sh
./sh/dist.cp.sh
