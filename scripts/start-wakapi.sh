#!/bin/bash

# SALT="$(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | LC_CTYPE=C fold -w ${1:-32} | head -n 1)"
SALT="XepjSfdTkYݳFOBt0wiE58HSTmz1V42Afb"

docker volume create wakapi-data

docker run -d \
  -p 9621:3000 \
  -e "WAKAPI_PASSWORD_SALT=$SALT" \
  -v wakapi-data:/data \
  --name wakapi \
  --restart unless-stopped \
  ghcr.io/muety/wakapi:latest
