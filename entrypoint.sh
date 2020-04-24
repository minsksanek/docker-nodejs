#!/bin/sh
set -e

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- node "$@"
fi

yarn
echo "Ready!"
pm2-runtime --watch server.js

/bin/bash