#!/bin/sh -l

if [ ! -f $1/checkov.yml ]; then
  cp /config_empty.yml $1/checkov.yml
fi

checkov -d $1 --config-file $1/checkov.yml -o github_failed_only
