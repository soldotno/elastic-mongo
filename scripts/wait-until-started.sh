#!/bin/bash

MONGODB1=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
ES=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

echo "Waiting for Elasticsearch to start."
until curl ${ES}:9200/_cluster/health?pretty 2>&1 | grep status | egrep "(green|yellow)"; do
  printf '.'
  sleep 1
done
echo "Elasticsearch started."
