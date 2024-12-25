#!/bin/bash

DIR=$HOME/Dropbox/MyPictures/neta

get_link() {
  name=$1
  cat ~/Dropbox/MyPictures/neta/link/images.json |
    jq -r '.[] | "\(.name) \(.link)"' |
    grep "$name " |
    head -1 |
    sed 's/^.* //' |
    sed 's/dl=0$/raw=1/'
}

import() {
  name=$1
  if ( cat db.jsonl | grep $name >/dev/null ); then
    : skip
    return
  fi
  OCRFILE="$DIR/ocr/$name.json"
  if [ ! -f $OCRFILE ]; then
    echo "No OCR found for $name" >&2
    exit 1
  fi
  link=$(get_link "$name")
  bash bin/commit --ocr-file $OCRFILE $link
}

for path in $DIR/*.*; do
  name="$(filename $path | jq -r .basename)"
  import $name
done
