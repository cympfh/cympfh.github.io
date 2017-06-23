#!/bin/bash

for f in *.pdf; do
  png=${f%pdf}png
  convert -density 200 $f $png
done

rm *.aux *.log *.dvi
