#!/bin/bash
COLOR_YELLOW='\033[1;49;33m';
COLOR_CLEAN='\033[0m';
COLOR_GREEN='\033[0;32m';

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $(dirname $SCRIPT_PATH)

echo " "
echo -e "${COLOR_YELLOW}========> Updating docker image...${COLOR_CLEAN}"
docker compose pull

echo " "
echo -e "${COLOR_YELLOW}========> Starting container...${COLOR_CLEAN}"
rm -f tmp/pids/server.pid
docker compose up -d
echo -ne "Waiting for bundle install ... "
(while (docker compose top app | egrep -o docker-entrypoint.sh); do sleep 1; done) >/dev/null 2>&1
echo -e "${COLOR_GREEN}done${COLOR_CLEAN}"

echo " "
echo -e "${COLOR_YELLOW}========> Updating database...${COLOR_CLEAN}"
echo -ne "Waiting for database ... "
docker compose exec app bash -c "while (! (</dev/tcp/postgres/5432) >/dev/null 2>&1); do sleep 1; done"
echo -e "${COLOR_GREEN}done${COLOR_CLEAN}"
(docker-compose exec app rails db:exists) && docker compose exec app rails db:migrate
(! docker-compose exec app rails db:exists) && docker compose exec app rails jobs:clear db:create db:migrate db:seed jobs:start

echo " "
echo -e "${COLOR_YELLOW}========> Starting service...${COLOR_CLEAN}"
docker logs app-api -n 8
docker attach app-api
