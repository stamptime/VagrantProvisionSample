#!/bin/sh

echo '\n---------------------------\n'
echo 'Running docker compose...'
sysctl -w vm.max_map_count=524288
sysctl -w fs.file-max=131072
ulimit -n 131072
ulimit -u 8192
cd /vagrant/
docker compose up -d
echo '\n---------------------------\n'
echo 'Success'