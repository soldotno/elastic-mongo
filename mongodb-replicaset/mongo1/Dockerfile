FROM mongo

RUN mongo --host 127.0.0.1:27017 <<EOF
    var cfg = {
        "_id": "rs",
        "version": 1,
        "members": [
            {
                "_id": 0,
                "host": "127.0.0.1:27017",
                "priority": 1
            },
            {
                "_id": 1,
                "host": "mongo2:27017",
                "priority": 1
            },
            {
                "_id": 2,
                "host": "mongo3:27017",
                "priority": 1
            }
        ]
    };


CMD mongod --replSet "rs0" \
           --dbPath /usr/local/var/mongodb \
           --engine wiredTiger \
           --port 27017 \
           --journal


