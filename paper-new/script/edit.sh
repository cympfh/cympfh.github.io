#!/bin/bash

F=$(ls -1 src/*/*.md | sort -r | peco)
if [ -z "$F" ]; then
    echo "canceled"
    exit
fi

$EDITOR "$F"
G=$(echo "$F" | sed 's/^src\///; s/\.md$/.html/')
make $G
