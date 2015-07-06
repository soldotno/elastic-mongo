# elastic-mongo
Docker setup to get Elasticsearch and MongoDB up and running

git clone git@github.com:soldotno/elastic-mongo.git
cd elastic-mongo
docker-compose up
##

Now you have Elasticsearch and MongoDB configured with mongodb-river.

```bash
docker-compose ps
                 Name                               Command               State                        Ports
---------------------------------------------------------------------------------------------------------------------------------
elasticmongo_elasticsearch_1             elasticsearch                    Up       0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp
elasticmongo_elasticsearchriversetup_1   /bin/sh -c curl ${RIVER_MA ...   Exit 0
elasticmongo_mongo1_1                    /usr/bin/mongod --replSet  ...   Up       0.0.0.0:27017->27017/tcp
elasticmongo_mongo2_1                    /usr/bin/mongod --replSet  ...   Up       0.0.0.0:27018->27017/tcp
elasticmongo_mongo3_1                    /usr/bin/mongod --replSet  ...   Up       0.0.0.0:27019->27017/tcp
elasticmongo_mongosetup_1                /scripts/setup.sh                Exit 0
```


