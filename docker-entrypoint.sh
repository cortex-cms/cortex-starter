#!/bin/sh
set -e

if [ "$DEPLOYED" != "true" ]
then
  bin/rails db:migrate 2>/dev/null || bin/rails db:setup cortex_starter:content_types:seed cortex:rebuild_indexes || true
fi

exec "$@"
