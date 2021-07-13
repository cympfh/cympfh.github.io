#!/bin/bash

listup() {
    echo today
    echo new
    find 20* -name '*.md' | sort -r | sed 's/.md$//g'
}

datetitle() {
    LC_ALL=C date -d "$1" "+%a %b %d %Y"
}

TOKEN=$(listup | peco $@)

if [ -z "$TOKEN" ]; then
    echo Canceled
    exit
fi

if [ "$TOKEN" = today ]; then
    TOKEN=$(LC_ALL=C date +"%Y/%m/%d")
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

vim -c "au BufWritePost *.md :silent !make $TOKEN.html >/dev/null 2>&1" "$TOKEN.md"
