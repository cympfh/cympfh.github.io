#!/bin/bash
#
# make menu.html
#

link_extension() {
  if [ "$PROD" = 1 ]; then
    sed 's/\.md//g'
  else
    sed 's/\.md/\.html/g'
  fi
}

link_extension |
pandoc |
  awk '
BEGIN { first = 1 }
!/<h1/ {
  print
}
/<h1/ {
  if (first != 1) { print "</details>\n" }
  first = 0
  gsub("<h1[^>]*>", "")
  gsub("</h1>", "")
  print "<details class=menu>"
  print "<summary class=menu>"$0"</summary>"
}
END {
  print "</details>"
}'
