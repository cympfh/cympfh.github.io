#!/bin/bash

USERAGENT="cympfh/VRCDynamicPoster"

# WORLD_ID
echo -n "WORLD_ID > "
read ID
ID=$(echo $ID | grep -o 'wrld_[a-z0-9-]*')
echo "ID=$ID"

# cache
CACHE=/tmp/$ID.html
if [ ! -f $CACHE ]; then
  echo "https://vrchat.com/home/launch?worldId=$ID > $CACHE"
  curl -sL -A "$USERAGENT" "https://vrchat.com/home/launch?worldId=$ID" >$CACHE
fi
TITLE=$(cat $CACHE | web-grep '<meta name="og:title" content={} />' | head -1)
DESCRIPTION=$(cat $CACHE | web-grep '<meta name="og:description" content={} />' | head -1)
echo "TITLE=$TITLE"
echo "DESCRIPTION=$DESCRIPTION"

# Fetching the thumbnail
OUT="./resources/img/$ID.png"
if [ ! -f "$OUT" ]; then
  IMURL=$(cat $CACHE | web-grep '<meta name="og:image" content={} />' | head -1)
  echo "$IMURL > $OUT"
  curl -sL -A $USERAGENT "$IMURL" > "$OUT"
fi

MKD="./src/$ID.md"
if [ ! -f "$MKD" ]; then
  echo "$ID $TITLE" >> src/postlist
  cat <<EOM >$MKD
% $TITLE
% $DESCRIPTION
% https://vrchat.com/home/launch?worldId=$ID
% {tags}
% rate:{0-10}

EOM
fi

echo $EDITOR $MKD
$EDITOR $MKD
make index
