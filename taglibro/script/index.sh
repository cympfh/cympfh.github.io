#!/bin/bash

## helpers

title() {
    head -1 "$1" | sed 's/^[#%] *//g'
}

summary() {
    grep '^## ' "$1" | sed 's,^## ,,; s,$,/,'
}

write-item() {
    MD=$1
    HTML=${MD%md}html
    cat <<EOM
    <div class="card">
        <header class="card-header">
            <a class="card-header-title" href="$HTML">$(title "$MD")</a>
        </header>
        <div class="card-content">
            $(summary "$MD")
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
  <title>taglibro/</title>
  <link rel="stylesheet" href="../resources/css/c.css" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
</head>
<body class="with-bg">
    <h1><i class="fa fa-save"></i> taglibro/</h1>
EOM

find . -name '*.md' | sort -r |
while read f; do
    write-item "$f"
done

cat <<EOM
</body>
</html>
EOM
