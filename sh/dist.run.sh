#!/usr/bin/env bash
WORKSPACE=$(realpath $0) && DIR=${DIR%/*}
cd $WORKSPACE
source ./env.sh
exec $WORKSPACE/_/Http/main.js
