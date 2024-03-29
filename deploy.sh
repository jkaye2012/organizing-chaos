#!/bin/bash

if [ -z "$1" ]; then
    echo "Please provide a commit message"
    exit 1
fi

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
cd "$SCRIPT_DIR" || exit 1

HUGO_ENV=production hugo
cd public || exit 2
git add .
git commit -m "$1"
git push
cd ..
git add .
git commit -m "$1"
git push
