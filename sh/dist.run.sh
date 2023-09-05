#!/usr/bin/env bash
WORKSPACE=$(realpath $0) && WORKSPACE=${WORKSPACE%/*}
source /etc/profile
cd $WORKSPACE
source ./env.sh
exec $WORKSPACE/_/Http/main.js
