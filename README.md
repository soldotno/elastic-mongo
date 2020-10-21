# Elastic Mongo
**Docker setup to get Elasticsearch and MongoDB up and running**



### Install Docker and docker-compose

* https://docs.docker.com/installation
* https://docs.docker.com/compose/install/

```bash

git clone https://github.com/stabenfeldt/elastic-mongo.git
cd elastic-mongo
docker-compose up
             
```

Now you have Elasticsearch and MongoDB configured with mongodb-river.

```bash
$ docker ps  # =>

CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS                  PORTS                                                NAMES
39ed9e7c6f33        elasticsearch:1.6   "/docker-entrypoint.   1 seconds ago       Up Less than a second   0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp       elasticmongo_elasticsearch_1
48f2b777abdf        mongo:3.1.5         "/usr/bin/mongod --r   2 seconds ago       Up 1 seconds            0.0.0.0:27017->27017/tcp, 0.0.0.0:28017->28017/tcp   elasticmongo_mongo1_1
7e6dd54b85e5        mongo:3.1.5         "/usr/bin/mongod --r   2 seconds ago       Up 1 seconds            0.0.0.0:27018->27017/tcp, 0.0.0.0:28018->28017/tcp   elasticmongo_mongo3_1
24e147982c2d        mongo:3.1.5         "/usr/bin/mongod --r   3 seconds ago       Up 2 seconds            0.0.0.0:27019->27017/tcp, 0.0.0.0:28019->28017/tcp   elasticmongo_mongo2_1

```

### Connect to the MongoDB cluster from your workstation
```
mongosh 0.0.0.0:27017
```

### Log into a container
```
docker-compose exec transporter bash
```
  
