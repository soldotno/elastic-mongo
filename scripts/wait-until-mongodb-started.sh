#!/bin/bash

echo "Waiting for the mongos to complete the election."
until curl http://mongo1:28017/isMaster\?text\=1  2>&1 | grep ismaster | grep true; do
  printf '.'
  sleep 1
done
echo "The primary is elected."

echo "Waiting for Elasticsearch to start."
until curl elasticsearch:9200/_cluster/health?pretty 2>&1 | grep status | egrep "(green|yellow)"; do
  printf '.'
  sleep 1
done
echo "Elasticsearch started."
