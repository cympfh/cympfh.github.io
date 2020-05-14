#!/bin/bash

new() {
    echo -n "AID (https://anidb.net/) > "
    read aid
    create $aid
    edit $aid
}

refresh-md-list() {
    find src -type f -name '*.md' |
        sed 's#/\([0-9]*\)\.md$#& \1#' |
        sort > resources/md-list
}

edit-list() {
    aid=$(
        cat resources/md-list |
            peco |
            awk '{print $2}'
    )
    [ -n "$aid" ] && edit $aid
}

create() {
    aid=$1
    year=$(anidb $aid | jq -r .date.start | sed 's/-.*//g')
    mkdir -p src/$year/

    title=$(anidb $aid | jq -r .title)

    pic=$(anidb $aid | jq -r '.picture[0]')
    if [ "$pic" != null ]; then
        pic="![](https://cdn-us.anidb.net/images/main/$pic)"
    else
        pic=""
    fi

    cat <<EOM > src/$year/$aid.md
# ${title}

EOM
    refresh-md-list
}

edit() {
    aid=$1
    src=$(
        cat resources/md-list |
            awk "\$2 == $aid { print \$1 } "
    )
    EDITOR=${EDITOR:-vim}
    $EDITOR $src
}

case "$1" in
    new )
        new
        ;;
    refresh )
        refresh-md-list
        ;;
    * )
        edit-list
        ;;
esac
