#!/bin/bash

ONYPHE="REPLACE_WITH_YOUR_APIKEY"

SEARCH=$1

if [ -z "$SEARCH" ]; then
	echo "Usage: $0 \"ONYPHE Query String\""
	exit 1
fi

MAX_PAGE=`curl -s "https://www.onyphe.io/api/search/datascan/$SEARCH?k=$ONYPHE" | jq .max_page`

echo "*** Last page: $MAX_PAGE"

for i in $(seq 1 $MAX_PAGE); do
	echo "*** Fetching page: $i"
	curl -s "https://www.onyphe.io/api/search/datascan/$SEARCH?k=$ONYPHE&page=$i" | jq '.results[]' -cM >> /tmp/datascan.json
	sleep 3
done