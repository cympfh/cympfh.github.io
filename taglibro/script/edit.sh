#!/bin/bash

listup() {
    echo today
    echo new
    find 20* -name '*.md' | sort -r | sed 's/.md$//g'
}

datetitle() {
    LANG=en date -d "$1" "+%a %b %d %Y"
}

TOKEN=$(listup | peco $@)

if [ -z "$TOKEN" ]; then
    echo Canceled
    exit
fi

if [ "$TOKEN" = today ]; then
    TOKEN=$(date +"%Y/%m/%d")
fi

if [ "$TOKEN" = new ]; then
    echo -n "YYYY/mm/dd > "
    read TOKEN
fi

if [ ! -d "$(dirname "$TOKEN")" ]; then
    mkdir -p "$(dirname "$TOKEN")"
fi

if [ ! -f "${TOKEN}.md" ]; then
    ( echo "% $(datetitle "$TOKEN")"; echo ) > "${TOKEN}.md"
fi

vim "$TOKEN.md"
make "$TOKEN.html"
