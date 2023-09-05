#!/usr/bin/env bash
set -e
DIR=$( dirname $(realpath "$0") )

cd $DIR

exec watchexec --shell=none \
  --project-origin . \
  -w . \
  --exts lua \
  -c \
  -r \
  -- ./test.lua
