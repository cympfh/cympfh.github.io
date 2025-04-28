#!/bin/bash

# src/YYYY/mm.md to YYYY/mm.html
SRC_MD="$1"

TITLE=$(cat ${SRC_MD} | awk 'NR==1' | sed 's/^% *//')
URL=$(cat ${SRC_MD} | awk 'NR==2' | sed 's/^% *//')
SHORT_SUMMARY=$(cat ${SRC_MD} | awk 'NR==3' | sed 's/^% *//')
TAGS=$(cat ${SRC_MD} | awk 'NR==4' | sed 's/^% *//')

# script/summaryblock.sh と揃えてる
TAGS_HTML=
for tag in ${TAGS}; do
  TAGS_HTML+="<span class=\"paper_tag\">${tag}</span>"
done

echo "TITLE: ${TITLE}" >&2
echo "URL: ${URL}" >&2

cat ${SRC_MD} |
  awk 'NR > 4' |
  unidoc \
    -T template/page.hbs \
    -V "title:${TITLE}" \
    -V "url:${URL}" \
    -V "short_summary:${SHORT_SUMMARY}" \
    -V "tags:${TAGS_HTML}"
