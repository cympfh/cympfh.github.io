#!/bin/bash

cat resources/index.header.html

ALBUMS="dosoku houbunsha tickets"
for a in $ALBUMS; do

    HASH=$(imgur album ls | grep "$a" | awk '{print $2}')
    LINK="https://imgur.com/a/${HASH}"

    cat <<EOM
<h2><a href=$LINK>${a}</a></h2>
<div class="outer">
    <div class="photos">
EOM

    imgur album ls "$a" | jq -Mrc .link | tac | head -n 20 |
    sed 's#.*#<a href=&><img src=&></a>#g'

    cat <<EOM
    </div>
</div>
<div class="footer"><a href=$LINK>$LINK</a></div>
EOM

done
