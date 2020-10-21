#!/bin/bash
set -e
# Any subsequent(*) commands which fail will cause the shell script to exit immediately

MONGODB1=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB2=`ping -c 1 mongo2 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB3=`ping -c 1 mongo3 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
ES=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`


/scripts/wait-until-mongodb-started.sh


################################
# Write to MongoDB

echo "================================="
echo "Writing to MongoDB"
mongo ${MONGODB1} <<EOF
  use harvester-test
  rs.config()
  var p = {title: "Breaking news", content: "It's not summer yet."}
  db.entries.save(p)
EOF


echo "================================="
echo "Fetching data from Mongo"
echo curl http://${MONGODB1}:28017/harvester-test/entries/?limit=10
curl http://${MONGODB1}:28017/harvester-test/entries/?limit=10
echo "================================="


################################
# Read from Elasticsearch

printf "\nWaiting for the transporter to start\n\n"

until test -f /scripts/TRANSPORTER-STARTED; do
  printf '.'
  sleep 1
done
printf "\nTransporter started \n\n"

printf "\nReading from Elasticsearch\n\n"
curl -XGET "http://${ES}:9200/harvester-test/_search?pretty&q=*:*"


echo "================================="
echo "DONE"
