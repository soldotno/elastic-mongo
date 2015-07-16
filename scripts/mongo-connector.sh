#!/bin/bash

MONGODB1=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB2=`ping -c 1 mongo2 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB3=`ping -c 1 mongo3 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
ELASTICSEARCH=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

echo "Waiting for MongoDB to start.."
until curl http://${MONGODB1}:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1; do
  printf '.'
  sleep 1
done
echo "MongoDB has started!"


apt-get update && apt-get install -y python-pip
pip install mongo-connector

mongo-connector --auto-commit-interval=0 -m ${MONGODB1}:27017 -t ${ELASTICSEARCH}:9200 -d elastic_doc_manager  --stdout
