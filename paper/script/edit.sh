#!/bin/bash

listup() {
    echo "*new"
    echo "*arxiv"
    cat resources/postlist | tac
}

ID=$(listup | peco --query "$1")
TITLE=title
URL=url

if [ "$ID" = "" ]; then
    echo "canceled"
    exit
fi

if [ "$ID" = "*new" ]; then
    echo -n "ID > "
    read ID
fi

if [ "$ID" = "*arxiv" ]; then
    echo -n "arxiv URL or ID > "
    read URL
    ARXIV_ID=$(echo "$URL" | grep -Eo '[0-9]{4}\.[0-9]*')

    URL="https://arxiv.org/abs/$ARXIV_ID"
    TITLE=$(curl -s "$URL" | grep '<title>' | head -1 | sed 's/^ *<title>//g; s#</title> *$##g')

    echo -n "ID for $TITLE > "
    read ID
fi

if [ ! -f "${ID}.md" ]; then
    echo "$ID" >> resources/postlist
    cat <<EOM > "$ID.md"
% $TITLE
% $URL
% tags

EOM
fi

vim "${ID}.md"
make "${ID}.html"
