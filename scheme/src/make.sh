#!/bin/bash

TMP=`mktemp`
for f in *.scm; do
  : > $TMP
  echo '```scheme' >> $TMP
  cat $f >> $TMP
  echo '```' >> $TMP
  pandoc -s -o $f.html $TMP
done

rm $TMP
