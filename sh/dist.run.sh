#!/usr/bin/env bash
WORKSPACE=$(realpath $0) && WORKSPACE=${WORKSPACE%/*}
cd $WORKSPACE
source ./env.sh
exec $WORKSPACE/_/Http/main.js
