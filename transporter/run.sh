#!/bin/bash

# Any subsequent(*) commands which fail will cause the shell script to exit immediately
set -e

printf "\nIN TRANSPORTER SETUP\n"

MARKER=/scripts/TRANSPORTER-STARTED


# Cleanup from previous runs 
if test -f "$MARKER"; 
	then rm $MARKER
fi


cd $GOPATH 
[  ! -f pkg ] || mkdir pkg

# Install Transporter
mkdir -p src/github.com/compose; cd src/github.com/compose

# Remove the transporter library if installed in a previous run.
[ -f transporter ] || rm -rf transporter

git clone https://github.com/compose/transporter && cd transporter
git checkout tags/v1.1.0

printf "\n\nGetting dependencies and building..\n\n"
go mod download
go build ./cmd/transporter/...

# At this point you should be able to run transporter via `$GOPATH/bin/transporter`,
# you may need to add $GOPATH to your PATH environment variable.
# Something along the lines of `export PATH="$GOPATH/bin:$PATH"` should work.
/scripts/wait-until-mongodb-started.sh

# Signal that we're starting
printf "=====================================\n\n"
printf Touching file
printf "=====================================\n\n"
touch $MARKER

TRANSPORTER_BIN=/go/src/github.com/compose/transporter/transporter

# cd into our mounted directory where config files are
cd /transporter

$TRANSPORTER_BIN test -log.level "info" pipeline.js
$TRANSPORTER_BIN run  -log.level "info" pipeline.js
