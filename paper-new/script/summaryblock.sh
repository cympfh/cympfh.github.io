#!/bin/bash
# index のためのサマリブロックを作る

# src/YYYY/mm.md
SRC_MD="$1"

# YYYY/mm
link=$(echo ${SRC_MD} | sed 's/src\///g' | sed 's/\.md$//g')

TITLE=$(cat ${SRC_MD} | awk 'NR==1' | sed 's/^% *//')
URL=$(cat ${SRC_MD} | awk 'NR==2' | sed 's/^% *//')
SHORT_SUMMARY=$(cat ${SRC_MD} | awk 'NR==3' | sed 's/^% *//')
TAGS=$(cat ${SRC_MD} | awk 'NR==4' | sed 's/^% *//')

TAGS_HTML=
for tag in ${TAGS}; do
  TAGS_HTML+="<span class=\"paper_tag\">${tag}</span>"
done

cat <<EOM
<article class="block">
  <p class="paper_title"><a href="${link}">${TITLE}</a></p>
  <p class="paper_url">
    <i class="ri-link"></i>
    <a href="${URL}">${URL}</a>
  </p>
  <p class="paper_summary">
    <i class="ri-lightbulb-flash-line"></i>
    ${SHORT_SUMMARY}
  </p>
  <div class="paper_tags">
    <i class="ri-hashtag"></i>
    ${TAGS_HTML}
  </div>
</article>
EOM
