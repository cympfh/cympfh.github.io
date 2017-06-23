#!/bin/bash

proc() {
  pandoc -t html5 --mathml -s --css ../../resources/css/c.css -i $1 -o $2
}

proc README.md index.html

for MD in `\ls -1 *.md | grep -v README`; do
  HTML=${MD%.md}.html
  proc $MD $HTML
done
