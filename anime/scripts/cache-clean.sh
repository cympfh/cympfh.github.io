#!/bin/bash

echo Scanning
for f in cache/*.xml; do
    if [ -z "$(head -c 6 $f)" ] || [ "$(cat $f)" = '<error code="500">banned</error>' ]; then
        echo rm -f $f ${f%xml}json
        rm -f $f ${f%xml}json
    fi
done
echo Done
