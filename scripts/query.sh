#!/bin/bash

MONGODB1=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB2=`ping -c 1 mongo2 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB3=`ping -c 1 mongo3 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
ES=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`


#MONGODB1=dockerhost
#ES=dockerhost
sleep 60
echo QUERY – time now: `date +"%T" `

echo "================================="
echo "Writing to MongoDB"

echo "Version 1"

mongo ${MONGODB1} <<EOF
  use harvestertest
  rs.config()
  var p = {title: "Breaking news", content: "It's not summer yet."}
  db.entries.save(p)
EOF

sleep 2

echo "================================="
echo "Fetching data from Mongo"
curl http://${MONGODB1}:28017/harvestertest/entries/?limit=10
echo "================================="


echo "Reading from Elasticsearch"
sleep 1
curl -XGET "http://${ES}:9200/harvestertest/_search?q=firstName:John&pretty"
echo "================================="

echo "DONE"

