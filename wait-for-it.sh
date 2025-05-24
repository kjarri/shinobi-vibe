#!/usr/bin/env bash
# wait-for-it.sh: Wait until a host:port is available
# Usage: wait-for-it.sh host:port -- command args

set -e

host="$1"
shift

until nc -z ${host%:*} ${host#*:}; do
  echo "Waiting for $host..."
  sleep 2
done

exec "$@"
