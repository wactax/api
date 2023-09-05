#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*/*}
cd $DIR
set -ex

OPT=/opt/xxai.art

API=$OPT/api
mkdir -p $API
rsync --quiet --delete -av lib/ $API
cp package.json $API

if ! [ -x "$(command -v sd)" ]; then
  cargo install sd
fi

awk '{gsub(/\.\/lib/, ".")}1' package.json >$API/package.json

cd $OPT
if [ ! -e conf ]; then
  ln -s $(dirname $DIR)/conf .
fi

cd $API
pnpm i --product
cp $DIR/env.sh .

if [ ! -f "run.sh" ]; then
  cat >./run.sh <<EOF
#!/usr/bin/env bash
WORKSPACE=$(realpath $0) && DIR=${DIR%/*}
cd $WORKSPACE
source ./env.sh
exec $WORKSPACE/_/Http/main.js
EOF

  chmod +x run.sh
fi
