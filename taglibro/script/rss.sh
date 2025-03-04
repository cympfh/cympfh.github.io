#!/bin/bash

date2822() {
    DATECOMMAND=date
    if ( type gdate 2>/dev/null ); then
        DATECOMMAND=gdate
    fi
    $DATECOMMAND --rfc-2822 $@
}

title() {
    head -1 "$1" | sed 's/^[#%] *//g' |
        html-encode
}

summary() {
    grep '^## ' "$1" | sed 's/^## //' |
        awk '{printf "%s; ", $0}' |
        html-encode
}

write-item() {
    MD=$1
    TITLE="$(title "$MD")"
    SUMMARY="$(summary "$MD")"
    LINKDATE=$(echo "$MD" | grep -o '20[0-9]*/[0-9]*/[0-9]*')
    PUBDATE=$(date2822 --date "$LINKDATE")
    cat <<EOM
  <item>
    <title>${TITLE}</title>
    <link>https://cympfh.cc/taglibro/${LINKDATE}</link>
    <description>
      ${SUMMARY}
    </description>
    <pubDate>${PUBDATE}</pubDate>
    <guid isPermaLink="true">https://cympfh.cc/taglibro/${LINKDATE}</guid>
  </item>
EOM
}

cat <<EOM
<rss version="2.0">
  <channel>
    <lastBuildDate>$(date2822)</lastBuildDate>
    <generator>@cympfh</generator>
    <title>cympfh.cc/taglibro</title>
    <link>https://cympfh.cc/taglibro</link>
    <description>@cympfh/taglibro</description>
EOM

find . -type f -name '*.md' | sort -r |
    head -n 100 |
    while read f; do
        write-item "$f"
    done

cat <<EOM
  </channel>
</rss>
EOM
