#!/bin/bash
set -e
# Any subsequent(*) commands which fail will cause the shell script to exit immediately

printf "\nIN TRANSPORTER SETUP\n"

MONGO=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
ES=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MARKER=/scripts/TRANSPORTER-STARTED


# Cleanup from previous runs
if test -f "$MARKER"; then
  rm $MARKER
fi

cd $GOPATH 
[  ! -f pkg ] || mkdir pkg

mkdir -p src/github.com/compose; cd src/github.com/compose
git clone https://github.com/compose/transporter; cd transporter
git checkout tags/v0.1.0

echo "Getting dependencies and building.."
go get github.com/tools/godep
godep restore
godep go build ./cmd/...
godep go install ./cmd/...


/scripts/wait-until-mongodb-started.sh

# Signal that we're starting
printf "=====================================\n\n"
printf Touching file
printf "=====================================\n\n"
touch $MARKER

cd /transporter
transporter run --config ./config.yaml ./mongo-es.js
