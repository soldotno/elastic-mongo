#!/bin/bash

MONGODB1=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB2=`ping -c 1 mongo2 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB3=`ping -c 1 mongo3 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

<<<<<<< HEAD
sleep 10
=======
sleep 20
>>>>>>> b187a2489e6205d70b4990d3d2edcd2d4929c845

mongo --host ${MONGODB1}:27017 <<EOF
   var cfg = {
        "_id": "rs",
        "version": 1,
        "members": [
            {
                "_id": 0,
                "host": "${MONGODB1}:27017",
                "priority": 2
            },
            {
                "_id": 1,
                "host": "${MONGODB2}:27017",
                "priority": 1
            },
            {
                "_id": 2,
                "host": "${MONGODB3}:27017",
                "priority": 1
            }
        ]
    };
    rs.initiate(cfg);
<<<<<<< HEAD
EOF
=======
EOF
>>>>>>> b187a2489e6205d70b4990d3d2edcd2d4929c845
