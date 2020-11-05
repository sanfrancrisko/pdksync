#!/bin/sh

set -e
set -v
export PATH=$PATH:$HOME/.rbenv/shims

ruby clone_managed_modules_https.rb

rm Gemfile.lock
bundle install

GITHUB_TOKEN=blah bundle exec rake 'pdksync:update_sync_yaml'
GITHUB_TOKEN=blah bundle exec rake 'pdksync:run_a_command[pdk update --force]'
GITHUB_TOKEN=blah bundle exec rake 'pdksync:generate_vmpooler_release_checks[7]'
GITHUB_TOKEN=blah bundle exec rake 'pdksync:generate_test_script'
