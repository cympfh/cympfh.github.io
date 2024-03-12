#!/bin/bash

listup() {
  cat src/postlist |
    uniq |
    tac
}

ID=$(listup | peco | awk '{print $1}')

if [ "$ID" = "" ]; then
    echo "canceled"
    exit
fi

$EDITOR "src/${ID}.md"
make index
