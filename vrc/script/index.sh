#!/bin/bash

mkdir -p cache/description
mkdir -p cache/innerhtml

postlist() {
  echo README
  cat src/postlist |
    grep -v '^#' |
    awk '{print $1}' |
    uniq |
    tac
}

# [0, 10] を星アイコンに変換する
rate-star() {
  # white: <i class="fa-regular fa-star"></i>
  # black: <i class="fa-solid fa-star"></i>
  # half: <i class="fa-regular fa-star-half-stroke"></i>
  RATE="$1"

  (
    N=$(echo "$RATE" | awk '{print int($1/2)}')
    for _ in `seq $N`; do
      echo '<i class="fa-solid fa-star"></i>'
    done
    N=$(echo "$RATE" | awk '{print ($1 % 2)}')
    for _ in `seq $N`; do
      echo '<i class="fa-regular fa-star-half-stroke"></i>'
    done
    for _ in `seq 5`; do
      echo '<i class="fa-regular fa-star"></i>'
    done
  ) | head -n 5
}

# TODO: 重たいようなら生成した HTML をキャッシュしておく
card() {
  WID=$1
  MKD="./src/$WID.md"
  TITLE=$(cat "$MKD" | awk 'NR==1{print}' | sed 's/^% *//g')
  make cache/description/$WID.html >/dev/null
  DESCRIPTION=$(cat cache/description/$WID.html)
  TAGS=$(cat "$MKD" | awk 'NR==4{print}' | sed 's/^% *//g')
  RATE=$(cat "$MKD" | awk 'NR==5{print}' | grep -o '[0-9]*')
  make cache/innerhtml/$WID.html >/dev/null
  INNERHTML=$(cat cache/innerhtml/$WID.html)
  cat <<EOM

<div class="column is-half world_column" data-tags="${TAGS}" >
  <div class="card" id="${WID}">
    <header class="card-header">
      <p class="card-header-title"><a href="#${WID}">${TITLE}</a></p>
      <a href="#${WID}" class="card-header-icon" aria-label="more options">
        <span class="icon is-link">
          <i class="fa fa-paperclip"></i>
        </span>
      </a>
      <a href="https://vrchat.com/home/launch?worldId=${WID}" target="_blank" class="card-header-icon" aria-label="more options">
        <span class="icon is-link">
          <i class="fa fa-external-link-alt"></i>
        </span>
      </a>
    </header>
    <div class="card-content">
      <div class="content">

        <div class="doc">
          <img src="resources/img/$WID.png" alt="$WID" />
          <blockquote>
            ${DESCRIPTION}
          </blockquote>
          <div>
            ${INNERHTML}
          </div>
        </div>

        <div class="collapse" wid="${WID}">
          <i class="fa fa-chevron-circle-down"></i>
        </div>

      </div>
    </div>
    <footer class="card-footer">
      <p class="card-footer-item is-info">
        $( echo "$TAGS" | awk '{ for (i=1; i<=NF; i++) print "<a class=\"tag is-blue\" href=\"#"$i"\">"$i"</a>" }' )
      </p>
      <p class="card-footer-item is-info">
        $( rate-star $RATE )
      </p>
    </footer>
  </div>
</div>

EOM
}

main() {
  cat <<TEMPLATE
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=0.9">
  <title>vrc/</title>
  <link rel="stylesheet" href="../resources/css/bulma/bulma.css" />
  <link rel="stylesheet" href="./resources/css/base.css" />
  <link rel="stylesheet" href="../resources/css/youtube.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.4.2/css/all.css" />
  </head>
<body>
  <section class="section">
    <div class="container">
        <h1 class="title"><i class="fa fa-map"></i> <a href="#">vrc/</a></h1>
    </div>
  </section>

  <section class="section main">
    <div class="container">
      <div class="columns is-multiline">
TEMPLATE

  postlist |
    while read wid; do
      echo "card $wid" >&2
      card "$wid"
    done

  cat <<TEMPLATE
      </div>
    </div>
  </section>

  <script src="./resources/js/base.js"></script>
  <script src="./resources/js/tag.js"></script>
  <script src="../resources/js/youtube.js"></script>
</body></html>
TEMPLATE
}

main > index.html
