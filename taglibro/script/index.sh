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
    cat <<EOM
    <div class="card">
        <header class="card-header">
            <a class="card-header-title" href="$HTML">$(title "$MD")</a>
        </header>
        <div class="card-content">
            <a href="$HTML">$(summary "$MD")</a>
        </div>
    </div>
EOM
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
  </style>
</head>
<body class="with-bg">

  <section class="section">
    <div class="container">
      <h1 class="title"><i class="fa fa-save"></i> taglibro/</h1>
    </div>

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
