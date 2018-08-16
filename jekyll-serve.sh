#!/bin/bash

host="localhost"
if [ "$1" != "" ]; then
    host="$1"
fi

bundle exec jekyll serve -H $host
