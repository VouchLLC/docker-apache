#!/usr/bin/env bash

set -e

idmod www-data "$USER_UID" "$USER_GID" || true

rm -f /var/run/apache2/apache2.pid

if [ $# -ne 0 ]; then
    exec tini -- "$@"
fi
