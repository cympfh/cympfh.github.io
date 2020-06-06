#!/bin/bash
#
# make menu.html
#

sed 's/\.md/\.html/g' |
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
