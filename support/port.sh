#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
ENV_FILE=`${DIR}/env-file.sh`

if [ -z $port ]; then
  port=$(awk -F "=" '/port/ {print $2}' $ENV_FILE)
fi

echo $port
