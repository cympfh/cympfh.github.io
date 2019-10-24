#!/bin/bash

echo "# anime/"
echo

for d in src/20*; do echo $d; done |
    sed 's/src.//g' |
    tac |
    sed 's,.*,- [&](&/index.md),g'
