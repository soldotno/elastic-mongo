#!/bin/bash

ES=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

echo "Waiting for startup.."
echo  curl ${ES}:9200 2>&1 | grep "You Know, for Search"
until curl ${ES}:9200 2>&1 | grep "You Know, for Search"; do
  echo '.'
  curl ${ES}:9200 2>&1
  sleep 1
done

echo "Done waiting!"

curl -XPUT ${ES}:9200/_cluster/settings -d '{
    "transient" : {
        "cluster.routing.allocation.disk.threshold_enabled" : false
    }
}'
