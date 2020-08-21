#!/bin/bash

POSTLIST=resources/postlist  # list of posts
TAGLIST=resources/taglist  # list of tags
TABLE=resources/table  # tag-post table

#
# write an item=paper by id
#
write-item() {
    MD="$1.md"
    HTML="$1"
    head -n 3 "$MD" | sed 's/^% *//g' | (
    read title; read url; read tags

    cat <<EOM
        <div class="card">
          <header class="card-header">
            <p class="card-header-title">
              <a href="$HTML" class="card-header-title">$title</a>
            </p>
          </header>
          <div class="card-content">
            <div class="content">
              <p class=abst>$(grep '^## ' "$MD" | sed 's,^## ,,; s,$,/,')</p>
              <p class="url"><a href="$url">$url</a></p>
              <p class="tags">
            $( echo "$tags" | awk '{ for (i=1; i<=NF; i++) print "<a href=\"#"$i"\" class=\"tag is-blue is-link\">"$i"</a>" }' )
              </p>
            </div>
          </div>
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
  <meta name="viewport" content="width=device-width, initial-scale=0.9">
  <title>paper/</title>
  <link rel="stylesheet" href="../resources/css/bulma/bulma.css" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
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
  <section class="section">
    <div class="container">
      <h1 class="title"><i class="fa fa-send-o"></i> paper/</h1>
    </div>
  </section>
TEMPLATE

#
# tag list
#
cat <<EOM
  <section class="section">
    <div class="container">
      <div class="tags">
        <a class="tag is-medium is-blue" href="#">(all)</a>
EOM

while read tag; do
    cat <<EOM
        <a class="tag is-medium is-blue" href="#$tag">$tag</a>
EOM
done < "$TAGLIST"

cat <<EOM
      </div>
    </div>
  </section>
EOM

#
# filtered items by tag
#
while read tag; do
    cat <<EOM
  <section class="section" id="$tag">
    <div class="container">
      <h3 class="title">$tag</h3>
EOM

    < "$TABLE" awk '$1 == "'"$tag"'"{print $2}' |
    while read id; do
        write-item "$id"
    done

    cat <<EOM
    </div>
  </section>
EOM
done < "$TAGLIST"

#
# all items
#
cat <<EOM
  <section class="section">
    <div class="container">
      <h3 class="title">all papers</h3>
EOM
< "$POSTLIST" awk '{A[NR]=$0} END{for(i=NR;i>=1;--i) print(A[i])}' |  # tac
while read id; do
    write-item "$id"
done

cat <<EOM
    </div>
  </section>
EOM
