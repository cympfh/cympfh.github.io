#!/bin/bash

POSTLIST=resources/md-list

card() {

    src="$1"
    aid="$2"
    title=$(head -1 $src | sed 's/^# *//g')

    ANIMETA="$(anidb $aid)"

    date_span=$(echo $ANIMETA | jq -r '.date | "\(.start) - \(.end)"')
    episodes=$(echo $ANIMETA | jq -r '"\(.type) - \(.episodecount) episodes"')
    companies=$(echo $ANIMETA | jq -r '.company | join(", ")')

    pic=$(echo $ANIMETA | jq -r '.picture[0]')
    if [ "$pic" != null ]; then
        pic="https://cdn-us.anidb.net/images/main/$pic"
    else
        pic=""
    fi

    cat <<EOM

<div class="card">
  <header class="card-header">
    <p class="card-header-title"><a name="${aid}" href="#${aid}">${title}</a></p>
    <a href="#${aid}" class="card-header-icon" aria-label="more options">
      <span class="icon">
        <i class="fa fa-angle-double-down" aria-hidden="true"></i>
      </span>
    </a>
  </header>
  <div class="card-content">
    <div class="content">

      <div class="eye-catch">
        <img class="eye-catch" src="$pic" />
      </div>

      <div class="doc" id="${aid}">
        $( cat ${src%md}html )
      </div>

    </div>
  </div>
  <footer class="card-footer">
    <p class="card-footer-item"><time>${date_span}</time></p>
    <p class="card-footer-item is-info">${episodes}</p>
    <p class="card-footer-item is-info">${companies}</p>
    <p class="card-footer-item"><i class="fa fa-link"></i> <a href="https://anidb.net/anime/${aid}">aniDB</a></p>
  </footer>
</div>

EOM

}

#
# HTML generation
#
cat <<TEMPLATE
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=0.9">
  <title>anime/</title>
  <link rel="stylesheet" href="../resources/css/bulma/bulma.css" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
  <style>

div.content {
  overflow: hidden;
}

div.card-content {
  padding: 0 !important;
}

div.doc {
  padding: 1.5rem;
  height: auto;
  transition-duration: 0.8s;
}

div.doc:target {
  height: auto;
  max-height: none;
  opacity: 1.0;
}

div.doc:not(target) {
  height: auto;
  max-height: 100px;
  opacity: 0.6;
}

div.content img.eye-catch {
  width: 100%;
  height: 160px;
  object-fit: cover;
}

aside.menu {
  position: fixed;
}

img:not(.eye-catch) {
width: 50%;
}

  </style>
  </head>
<body>

  <section class="section">
    <div class="container">
        <h1 class="title"><i class="fa fa-tv"></i> anime/</h1>
    </div>
  </section>

  <section class="section">
    <div class="container">
TEMPLATE

last_year=0
cat $POSTLIST |
    tac |
    while read src aid; do
        year=$(echo $src | sed 's#^src/##; s#/.*##g')
        if [ $last_year -ne $year ]; then
            echo "<section class=hero><div class=hero-body><div class=container><h2 class=title>$year</h2></div></div></section>"
            last_year=$year
        fi
        card "$src" "$aid"
    done

cat <<TEMPLATE
    </div>
  </section>

</body></html>
TEMPLATE
