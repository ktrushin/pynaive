#!/bin/sh

set -e

prog=$(basename $0)
if [ ! -d ".git" ]; then
  echo "Error: $prog must be called from the project's root directory."
  exit 1
fi

python3 -m pytest
