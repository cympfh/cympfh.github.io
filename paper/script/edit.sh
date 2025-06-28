#!/bin/bash

listup() {
    echo "*new"
    echo "*arxiv"
    ls -1 src/*/*.md | sort -r
}

arxiv-title() {
    withcache -- curl -sL "$1" | web-grep "<title>{}</title>"
}

arxiv-year() {
    withcache -- curl -sL "$1" | web-grep '<meta name="citation_date" content={}>' |
        grep -o '^[0-9]*'
}

F=$(listup | peco --query "$1")

if [ -z "$F" ]; then
    echo "canceled"
    exit
fi

if [ "$F" = "*new" ]; then
    echo -n "Page ID > "
    read page_id
    echo -n "Year (YYYY) > "
    read year

    F=src/$year/$page_id.md
    if [ ! -f "$F" ]; then
        mkdir -p src/$year
        cp template/page.md "$F"
    else
        echo "$F already exists. Exiting." >&2
        exit 1
    fi
fi

if [ "$F" = "*arxiv" ]; then
    echo -n "arxiv URL > "
    read URL
    echo -n "Page ID > "
    read page_id

    ARXIV_ID=$(echo "$URL" | grep -Eo '[0-9]{4}\.[0-9]*')
    ARXIV_URL="https://arxiv.org/abs/$ARXIV_ID"
    ARXIV_TITLE=$(arxiv-title "$ARXIV_URL")
    ARXIV_YEAR=$(arxiv-year "$ARXIV_URL")
    F=src/$ARXIV_YEAR/$page_id.md

    if [ ! -f "$F" ]; then
        mkdir -p src/$ARXIV_YEAR
        cat template/page.md |
            sed "1s@TITLE@${ARXIV_TITLE}@" |
            sed "2s@URL@${ARXIV_URL}@" >$F
    else
        echo "$F already exists. Exiting." >&2
        exit 1
    fi
fi

$EDITOR "$F"
G=$(echo "$F" | sed 's/^src\///; s/\.md$/.html/')
make $G
