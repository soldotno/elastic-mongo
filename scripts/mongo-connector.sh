#!/bin/bash

MONGODB1=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
ELASTICSEARCH=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`


pip install mongo-connector
touch /scripts/mongo-connector-installed

printf "\n\nWaiting for MongoDB to start\n"
until curl http://${MONGO_URL}:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1; do
  printf '.'
  sleep 1
done
echo "MongoDB has started!"

echo "\n\nStarting mongo-connector.."
mongo-connector --auto-commit-interval=5 -m ${MONGO_URL}:27017 -t ${ELASTICSEARCH_URL} -v -d elastic_doc_manager --stdout
