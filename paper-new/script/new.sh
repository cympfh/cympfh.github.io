#!/bin/bash

echo -n "Page ID > "
read page_id
echo -n "Year (YYYY) > "
read year

mkdir -p src/$year
F=src/$year/$page_id.md
if [ ! -f "$F" ]; then
  cp template/page.md "$F"
else
  echo "$F already exists. Exiting." >&2
fi

$EDITOR "$F"
