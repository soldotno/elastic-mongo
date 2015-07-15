# Elastic Mongo
**Docker setup to get Elasticsearch and MongoDB up and running**



### Install Docker and docker-compose
https://docs.docker.com/installation
https://docs.docker.com/compose/install/

```bash

git clone https://github.com/soldotno/elastic-mongo.git
cd elastic-mongo
docker-compose up -d  # If you skip -d, then the entire clusted will go down when
                      # mongosetup and elasticsearch-river-setup are done.
```

Now you have Elasticsearch and MongoDB configured with mongodb-river.

```bash
docker-compose ps  # =>

                 Name                               Command               State                        Ports
---------------------------------------------------------------------------------------------------------------------------------
elasticmongo_elasticsearch_1             elasticsearch                    Up       0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp
elasticmongo_elasticsearchriversetup_1   /bin/sh -c curl ${RIVER_MA ...   Exit 0
elasticmongo_mongo1_1                    /usr/bin/mongod --replSet  ...   Up       0.0.0.0:27017->27017/tcp
elasticmongo_mongo2_1                    /usr/bin/mongod --replSet  ...   Up       0.0.0.0:27018->27017/tcp
elasticmongo_mongo3_1                    /usr/bin/mongod --replSet  ...   Up       0.0.0.0:27019->27017/tcp
elasticmongo_mongosetup_1                /scripts/setup.sh                Exit 0
```

## Configuring your river
Update [docker-compose.yml](https://github.com/soldotno/elastic-mongo/blob/master/docker-compose.yml) to your likings.

`RIVER_MAPPING` must point to a JSON file that describes which MongoDB database and collection to index.
At SOL we index entries in the harvester database. It looks like this:

```javascript
{
    index: {
        name: "harvester",
        type: "entries"
    },
    type: "mongodb",
    mongodb: {
        servers: [
            {
                host: "mongo1"
            },
            {
                host: "mongo2"
            },
            {
                host: "mongo3"
            }
        ],
        gridfs: false,
        collection: "entries",
        db: "harvester"
    }
}
```
