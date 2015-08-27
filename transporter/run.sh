#!/bin/bash

MONGO=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
ES=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`


# This script should only start transporter. The installation should be done in an image.

cd $GOPATH; mkdir pkg
mkdir -p src/github.com/compose; cd src/github.com/compose
git clone https://github.com/compose/transporter; cd transporter
git checkout tags/v0.1.0

echo "Getting dependencies and building.."
go get github.com/tools/godep
godep restore
godep go build ./cmd/...
godep go install ./cmd/...


/scripts/wait-until-started.sh

cd /transporter
transporter run --config ./config.yaml ./mongo-es.js
