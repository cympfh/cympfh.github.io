#!/bin/bash

SRC="$1"
BASENAME=${SRC%.md}

content() {
  if [ -z "$SRC" ]; then
    :
  else
    cat $SRC | mdc | pandoc -t html5 --mathjax
  fi
}

menu-open() {
    if [ -z "$SRC" ]; then
        cat
    else
        tac |
            awk "
BEGIN { bl=0 }
/$BASENAME/ { bl = 1 }
/<details/ {
    if (bl == 1) {
        gsub(\">\", \" open>\")
    }
    bl = 0
}
{
    print
}
" |
        tac
    fi
}

cat <<EOM
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>procon/</title>

    <link rel="stylesheet" href="./resources/c.css">
    <link rel="stylesheet" href="./resources/highlight.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.5/css/bulma.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

  </head>
  <body>
    <section class="section">
      <div class="container">
        <section class="main-content columns is-fullheight">

          <div class="article column is-8 is-10-mobile">
            <div class="content">
              $(content)
            </div>
          </div>

          <aside class="menu column is-3 is-narrow-mobile is-fullheight section">
$(cat menu.html | menu-open)
          </aside>

        </section>
    </div>
  </section>
  </body>
</html>
EOM
