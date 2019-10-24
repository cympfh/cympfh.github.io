#!/bin/bash

make_page() {
    y=$1
    echo "# anime/$y/"
    find src/$y -type f -name "*.md" |
        grep -v README |
        tac |
        while read f; do
            TITLE=$(head -1 $f | sed 's/# *//g')
            LINK=$(echo $f | sed 's,src/20[0-9]*/,,g')
            echo "- [$TITLE]($LINK)"
        done
}

for y in $(seq 1950 2100); do
    if [ ! -d src/$y ]; then continue; fi
    make_page $y > src/$y/README.md
done
