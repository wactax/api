#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

name=xxai-api

service_sh=/opt/xxai.art/api/srv.sh

chmod +x $service_sh

system_service=/etc/systemd/system/$name.service
cp ./service $system_service

sed -i "s#EXEC#${service_sh}#" $system_service

systemctl daemon-reload

systemctl enable --now $name
systemctl restart $name

systemctl status $name --no-pager || true

journalctl -u $name -n 10 --no-pager --no-hostname
