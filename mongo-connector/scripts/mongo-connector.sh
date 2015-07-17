#!/bin/bash


pip install mongo-connector
touch /scripts/mongo-connector-installed

echo "\n\nStarting mongo-connector.."
mongo-connector -m ${MONGO_URL} -t ${ELASTICSEARCH_URL} -d elastic_doc_manager --stdout -v
