#!/bin/bash

POSTLIST=resources/md-list

card() {

    src="$1"
    aid="$2"
    title=$(head -1 $src | sed 's/^# *//g')

    ANIMETA="$(anidb $aid)"

    date_span=$(echo $ANIMETA | jq -r '.date | "\(.start) - \(.end)"')
    episodes=$(echo $ANIMETA | jq -r '"\(.type) - \(.episodecount) episodes"')
    companies=$(echo $ANIMETA | jq -r 'if .company then (.company | join(", ")) else empty end')

    pic=$(echo $ANIMETA | jq -r '.picture? | .[0]')
    if [ "$pic" != null ]; then
        pic="https://cdn-us.anidb.net/images/main/$pic"
    else
        pic=""
    fi

    cat <<EOM

    <div class="column is-half">

<div class="card" id="${aid}">
  <header class="card-header">
    <p class="card-header-title"><a href="#${aid}">${title}</a></p>
    <a href="https://anidb.net/anime/${aid}" target="_blank" class="card-header-icon" aria-label="more options">
      <span class="icon has-text-danger">
        <i class="fa fa-database" aria-hidden="true"></i>
      </span>
    </a>
  </header>
  <div class="card-content">
    <div class="content">

      <div class="doc">
        $( cat ${src%md}html )
      </div>

      <div class="collapse" aid="$aid">
        <i class="fa fa-chevron-circle-down"></i>
      </div>

    </div>
  </div>
  <footer class="card-footer">
    <p class="card-footer-item"><time>${date_span}</time></p>
    <p class="card-footer-item is-info">${episodes}</p>
    <p class="card-footer-item is-info">${companies}</p>
  </footer>
</div>

    </div>

EOM

}

card-year() {
  cat <<EOM
    <a name="year-$1"></a>
    <div class="column is-half" id="bread-$1">
      <div class="card card-year">
        <div class="card-content year">
          <div class="content">
            <span class="title">$1</span>
          </div>
        </div>
      </div>
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
  <link rel="stylesheet" href="./resources/css/base.css" />
  <link rel="stylesheet" href="./resources/css/menu.css" />
  <link rel="stylesheet" href="../resources/css/youtube.css" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
  </head>
<body>

  <aside class="menu">
    <ul class="menu-list">
TEMPLATE

  cat resources/md-list | awk -F/ '$0=$2' | uniq | sort -nr |
    sed 's,.*,<li><a href="#year-&">&</a></li>,'

cat <<TEMPLATE
    </ul>
  </aside>

  <section class="section">
    <div class="container">
        <h1 class="title"><i class="fa fa-tv"></i> anime/</h1>
    </div>
  </section>

  <section class="section main">
    <div class="container">
      <div class="columns is-multiline">
TEMPLATE

last_year=0
cat $POSTLIST |
    awk '{print $1,$2}' |
    tac |
    while read src aid; do
        year=$(echo $src | sed 's#^src/##; s#/.*##g')
        if [ $last_year -ne $year ]; then
            card-year "$year"
            last_year=$year
        fi
        card "$src" "$aid"
    done

cat <<TEMPLATE
      </div>
    </div>
  </section>

  <script src="./resources/js/base.js"></script>
  <script src="../resources/js/youtube.js"></script>

</body></html>
TEMPLATE
