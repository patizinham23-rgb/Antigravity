#!/usr/bin/env bash
set -euo pipefail

bundle install --jobs 4
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
