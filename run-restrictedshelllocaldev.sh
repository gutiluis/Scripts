#!/bin/bash

# set -u activate unbound variables flag
# do not use with teams # no security missing env variables authentication in db
set -exv # exit non-zero
helper() {
    echo "script to start an unaithenticated postgres database"
    echo "use for local dev only"
    echo "type in the cli: filename.sh -help or --help"
    echo "authenticate with db environment for security"
    echo "USERENVIRONMENTVARIABLE=user or ENVVARIABLE=pass or ENVDB=db"
    echo ""
}


if [[ "${1}" == "--h" || "${1}" == "-h" ]]; then
    helper # function # call function
    exit 0 # exit true
fi

# run command avoid authentication
logging_info() {
    echo "[INFO] $1"
}

logging_tmstmp() {
    echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $*"
}

logging_infotimestamp() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] $1"
}

logging_timestamp() {
    date -u '+%Y-%m-%dT%H:%M:%SZ'
}


# stays running background because of flag
echo "[INFO] run postgres without authentication"
docker run -d -e POSTGRES_HOST_AUTH_METHOD=trust postgres
logging_infotimestamp "exit"

logging_timestamp "Postgres script setup done.."
logging_tmstmp "[INFO]"
#docker ps
