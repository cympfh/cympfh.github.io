#!/bin/bash

listup() {
    echo new
    cat resources/postlist | tac
}

ID=$(listup | peco)

if [ "$ID" = "" ]; then
    echo "canceled"
    exit
fi

if [ "$ID" = new ]; then
    echo -n "ID > "
    read ID
fi

if [ ! -f "${ID}.md" ]; then
    echo "$ID" >> resources/postlist
    cat <<EOM > "$ID.md"
% title
% $(LANG=en date "+%Y-%m-%d (%a.)")
% tags

EOM
fi

vim "${ID}.md"
make "${ID}.html"
