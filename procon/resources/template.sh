#!/bin/bash

SRC="$1"
BASENAME=${SRC%.md}

content() {
  if [ -z "$SRC" ]; then
    :
  else
    cat $SRC | unidoc
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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>procon/</title>
    <style type="text/css">code{white-space: pre;}</style>
    <link rel="stylesheet" href="./resources/c.css">
    <link rel="stylesheet" href="https://unpkg.com/prismjs@1.x.0/themes/prism.css" />
    <script id="MathJax-script" async src="https://unpkg.com/mathjax@3/es5/tex-svg-full.js"></script>
  </head>
  <body>
    <div class="two-columns">
      <div class="column-left-80">
        $(content)
      </div>
      <div class="column-right-20 menu">
$(cat menu.html | menu-open)
      </div>
    </div>
    <script src="https://unpkg.com/prismjs@v1.x/components/prism-core.min.js"></script>
    <script src="https://unpkg.com/prismjs@v1.x/plugins/autoloader/prism-autoloader.min.js"></script>
  </body>
</html>
EOM
