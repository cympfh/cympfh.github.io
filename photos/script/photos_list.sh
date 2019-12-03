#!/bin/bash

# imgur
ALBUMS="tickets dosoku houbunsha"
for a in $ALBUMS; do
    imgur album ls $a | jq -r .link
done
