#!/bin/bash

POSTLIST=resources/postlist  # list of posts
TAGLIST=resources/taglist  # list of tags
TABLE=resources/table  # tag-post table

#
# write an item by id
#
write-item() {
    MD="$1.md"
    HTML="$1.html"
    head -n 3 "$MD" | sed 's/^..//g' | (
        read title; read date; read tags
        cat <<EOM
    <div class="item">
        <p class="title"><a href="$HTML">$title</a></p>
        <p class="tags">
$( echo "$tags" | awk '{ for (i=1; i<=NF; i++) print "<a href=\"#"$i"\" class=\"tag\">"$i"</a>" }' )
        </p>
        <p class="date">$date</p>
        <p class=abst>
$(grep '^## ' $MD | sed 's,^## ,<span class=abst>,; s,$,</span>,')
        </p>
    </div>
EOM
    )
}

#
# update id-list
#
diff <(sort "$POSTLIST") <(find . -name '*.md' | sed 's,\./,,g; s,\.md,,g' | sort) |
grep '^>' | sed 's/> //g' >/tmp/append
cat /tmp/append >>$POSTLIST
rm /tmp/append

#
# cache tag-list
#
< "$POSTLIST" awk '{A[NR]=$0} END{for(i=NR;i>=1;--i) print(A[i])}' |  # tac
while read id; do
    head -n 3 "$id.md" | tail -1 |
    sed 's/%//g; s/tags//g; s/  */ /g; s/^ //g; s/ $//g' |
    tr ' ' '\n' |
    while read tag; do
        [ -z "$tag" ] || echo "$tag $id"
    done
done >"$TABLE"

< "$TABLE" awk '{print $1}' | sort -u > $TAGLIST

#
# HTML generation
#
cat <<TEMPLATE
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>aiura/</title>
  <link rel="stylesheet" href="../resources/css/c.css">
  <link rel="stylesheet" href="resources/index.css">
  <style>
TEMPLATE

while read tag; do
    cat <<EOM
#${tag}:target { display: block }
#${tag}:not(target) { display: none }
EOM
done < "$TAGLIST"

cat <<TEMPLATE
  </style>
  </head>
<body>
<h1>aiura/</h1>
TEMPLATE

#
# tag list
#
cat <<EOM
<div class="taglist">
    <a class="tag" href="#">(all)</a>
EOM

while read tag; do
    cat <<EOM
    <a class="tag" href="#$tag">$tag</a>
EOM
done < "$TAGLIST"

cat <<EOM
</div>
EOM

#
# filtered items by tag
#
while read tag; do
    cat <<EOM
<div class="tagitem" id="$tag">
<h3>$tag</h3>
EOM

    < "$TABLE" awk '$1 == "'"$tag"'"{print $2}' |
    while read id; do
        write-item "$id"
    done

    cat <<EOM
</div>
EOM
done < "$TAGLIST"

#
# all items
#
echo "<h3>all items</h3>"
< "$POSTLIST" awk '{A[NR]=$0} END{for(i=NR;i>=1;--i) print(A[i])}' |  # tac
while read id; do
    write-item "$id"
done
