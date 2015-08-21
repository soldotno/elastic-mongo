#!/bin/bash

ES=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

echo "Waiting for startup.."
until curl ${ES}:9200/_cluster/health?pretty | grep status | egrep "(green|yellow)" 2>&1; do
  printf '.'
  sleep 2
done

echo "Done waiting!"

curl -XPUT ${ES}:9200/_cluster/settings -d '{
    "transient" : {
        "cluster.routing.allocation.disk.threshold_enabled" : false
    }
}'
