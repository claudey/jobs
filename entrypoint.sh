#!/bin/bash

gem install bundler
bundle install --binstubs="$BUNDLE_BIN"

if [[ "$@" == *"rails s"* ]]; then
  # only remove pid when running rails
  if [ -f /app/tmp/pids/server.pid ]; then
    rm /app/tmp/pids/server.pid
  fi
fi

exec "$@"