#!/bin/bash

MONGODB1=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB2=`ping -c 1 mongo2 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB3=`ping -c 1 mongo3 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
ES=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

echo "================================="
# Output available disk space. Full disk will happen unless we find a
# way to clean up all the containers we create.
echo "Disk space"
echo `df -h`
echo "=================================\n\n"


echo "Waiting for the mongos to complete the election."
until curl http://${MONGODB1}:28017/isMaster\?text\=1  2>&1 | grep ismaster | grep true; do
  printf '.'
  sleep 1
done
echo "The primary is elected."

echo "Waiting for Elasticsearch startup."
until curl ${ES}:9200 2>&1 | grep status | grep green; do
  echo '.'
  curl ${ES}:9200 2>&1
until curl ${ES}:9200/_cluster/health?pretty 2>&1 | grep status | grep green; do
  sleep 1
done
echo "Elasticsearch started."



echo "================================="
echo "Writing to MongoDB"

mongo ${MONGODB1} <<EOF
  use harvester
  rs.config()
  var p = {title: "Breaking news", content: "It's not summer yet."}
  db.entries.save(p)
EOF

sleep 2

echo "================================="
echo "Fetching data from Mongo"
echo curl http://${MONGODB1}:28017/harvester/entries/?limit=10

curl http://${MONGODB1}:28017/harvester/entries/?limit=10

echo "================================="


echo "Waiting for mongo-connector to be installed"
TOUCH_FILE='/scripts/mongo-connector-installed'

until [ -f $TOUCH_FILE ]; do
  printf '.'
  sleep 1
done

printf "\nReading from Elasticsearch (sleeping 20 seconds first)"
sleep 20
echo curl -XGET http://${ES}:9200/harvester/_search?pretty&q=*:*
curl -XGET "http://${ES}:9200/harvester/_search?pretty&q=*:*"


echo "================================="

echo "DONE"
rm $TOUCH_FILE

