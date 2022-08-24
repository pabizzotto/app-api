#!/bin/bash
COLOR_YELLOW='\033[1;49;33m';
COLOR_CLEAN='\033[0m';
COLOR_GREEN='\033[0;32m';

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $(dirname $SCRIPT_PATH)

echo " "
echo -e "${COLOR_YELLOW}========> Starting container...${COLOR_CLEAN}"
docker compose up -d
echo -ne "Waiting for bundle install ... "
(while (docker compose top app | egrep -o docker-entrypoint.sh); do sleep 1; done) >/dev/null 2>&1
echo -e "${COLOR_GREEN}done${COLOR_CLEAN}"


echo " "
echo -ne "Waiting for database ... "
docker compose exec app bash -c "while (! (</dev/tcp/postgres/5432) >/dev/null 2>&1); do sleep 1; done"
echo -e "${COLOR_GREEN}Kill all connections${COLOR_CLEAN}"
docker compose exec postgres psql -h localhost -U postgres -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pid <> pg_backend_pid();"
echo -e "${COLOR_YELLOW}========> Reseting databse...${COLOR_CLEAN}"
docker compose exec app rails jobs:clear db:drop db:create db:migrate db:seed jobs:start DISABLE_DATABASE_ENVIRONMENT_CHECK=1


echo " "
echo -e "${COLOR_YELLOW}========> Starting service...${COLOR_CLEAN}"
docker compose exec -d app sidekiq -C config/sidekiq.yml
docker logs app-api -n 8
docker attach app-api
