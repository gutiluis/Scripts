#!/bin/bash


# after downloading the image
# connect with psql official image


# -v not used in production
set -exu

helper_function(){
    echo "[INFO] open postgres shell from a docker container"
    echo "[INFO] after downloading the image and the container, open the shell"
    echo "can add a verbose flag to set -v but not in production"
    echo "to use add: filename.sh '--help' or '-h'"
    echo "end"
    echo ""
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    helper_function
    exit 0
fi;

logging_info(){
    echo "[INFO] $1"
}
logging_info "has already docker image OR remove it and restart"

echo "[INFO] Removing old container if it exists..."
docker rm -f pg >/dev/null 2>&1 || true

echo "[INFO] Starting PostgreSQL..."
docker run -d \
  --name pg \
  -p 5433:5432 \
  -e POSTGRES_HOST_AUTH_METHOD=trust \
  postgres

echo "[INFO] Waiting for PostgreSQL to be ready..."

until docker exec pg pg_isready -U postgres > /dev/null 2>&1; do
  sleep 1
done

echo "[INFO] PostgreSQL is ready"
docker exec -it pg psql -U postgres

# do not use the block with set -e exit non zero
# if exit is not zero and is false only zero is true
# check exit status of docker exec
#if [[ "$?" -ne 0 ]]; then
#    echo '[ERROR] Connection failed'
#    exit 1
#fi
