#!/bin/bash

## helpers

title() {
    head -1 "$1" | sed 's/^[#%] *//g'
}

summary() {
    grep '^## ' "$1" | sed 's/^## //' |
      sed 's,^.*,<span class="subtitles"><i class="fas fa-check"></i>&</span>,'
}

write-item() {
    MD=$1
    HTML=${MD%.md}
    Y=$(echo "$HTML" | grep -o '20[0-9][0-9]')
    cat <<EOM
    <div class="card card-$Y">
        <header class="card-header">
            <a class="card-header-title" href="$HTML">$(title "$MD")</a>
        </header>
        <div class="card-content">
            <a href="$HTML">$(summary "$MD")</a>
        </div>
    </div>
EOM
}

years() {
    find . -maxdepth 1 -type d | grep -o '20[0-9]*' | sort -nr
}

## entry

cat <<EOM
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=0.9">
  <title>taglibro/</title>
  <link rel="stylesheet" href="../resources/css/bulma/bulma.css" />
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" />
  <script type="text/javascript" src="resouces/js/years.js"></script>
  <style>
    .card-header {
      background-color: #fafafa;
      transition: all 0.2s ease-in-out;
    }
    .card-header:hover {
      background-color: #f0f0f0;
    }
    .card-content > a {
      cursor: pointer;
      color: black;
    }
    .card-content:hover {
      background-color: #fafafa;
    }
    i.fas, i.far {
      padding-right: 0.2rem;
    }
    span.subtitles {
      padding-right: 0.6rem;
    }
    div.hidden {
      display: none;
    }
  </style>
</head>
<body class="with-bg">

  <!-- navbar -->
  <section class="section">
    <div class="container">
      <nav class="navbar" role="navigation" aria-label="main navigation">
        <div class="navbar-brand">
          <a class="navbar-item">
            <p class="subtitle is-3"><i class="fa fa-save"></i> taglibro/</i></p>
          </a>
        </div>
        <div class="navbar-menu">
          <div class="navbar-end">
            <div class="navbar-item">
              <div class="buttons">
                <div class="navbar-item has-dropdown is-hoverable">
                  <a class="navbar-link button" id="y-midashi">All</a>
                  <div class="navbar-dropdown">
                    <a class=navbar-item href=#>All</a>
                    $(
                        for y in $(years); do
                            echo "<a class=navbar-item href=#$y>$y</a>"
                        done
                    )
                  </div>
                </div>
                <a class="button is-light" href="rss.xml"><i class="fa fa-rss"></i></a>
              </div>
            </div>
          </div>
        </div>
      </nav>
    </div>
  </section>

  <!-- articles by years -->
  <section class="section">

    <div class="container">
EOM

find . -name '*.md' | sort -r |
while read f; do
    write-item "$f"
done

cat <<EOM
    </div>
  </section>
</body>
</html>
EOM
