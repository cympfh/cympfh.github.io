#!/bin/bash

cat <<EOM
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>taglibro/</title>
  <link rel="stylesheet" href="../resources/css/c.css" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
</head>
<body class="with-bg">
    <h1><i class="fa fa-save"></i> taglibro/</h1>
EOM

find . -name '*.md' | sort -r |
while read f; do
    MD=$f
    HTML=${f%md}html
    cat <<EOM
    <div class="card">
        <header class="card-header">
            <a class="card-header-title" href="$HTML">$(head -1 "$MD" | sed 's/^..//g')</a>
        </header>
        <div class="card-content">
            $(grep '^## ' "$MD" | sed 's,^## ,,; s,$,/,')
        </div>
    </div>
EOM

done

cat <<EOM
</body>
</html>
EOM
