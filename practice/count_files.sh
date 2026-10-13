#!/usr/bin/env bash

count=$(LC_ALL=C ls -1A --quoting-style=escape | wc -l)
printf 'directory count: %d\n' "$count"
