#!/bin/bash

years() {
  for y in $(ls -1 src | sort -nr); do
    if find src/$y -type f -print -quit | grep -q .; then
      echo $y
    fi
  done
}

# caching
mkdir -p cache
for y in $(years); do
  bash script/banner.sh "$y" > cache/$y.html
  for f in src/$y/*.md; do
    mkdir -p cache/$y
    g=$(echo $f | sed 's/^src/cache/g' | sed 's/\.md/.html/g')
    make $g 1>&2
  done
done

HTML_LIST=()
mkdir -p cache
for y in $(years); do
  HTML_LIST+=("-A" "cache/$y.html")
  bash script/banner.sh "$y" > cache/$y.html
  for f in src/$y/*.md; do
    g=$(echo $f | sed 's/^src/cache/g' | sed 's/\.md/.html/g')
    HTML_LIST+=("-A" "$g")
  done
done

unidoc template/index.md -T template/index.hbs ${HTML_LIST[@]}
