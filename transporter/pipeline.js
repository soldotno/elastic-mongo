var source = mongodb({
  uri: "mongodb://mongo1:28017/harvester-test",
  // uri: "https://username:password@hostname:port/INDEX_NAME",

  // "timeout": "30s",
  // "tail": false,
  // "ssl": false,
  // "cacerts": ["/path/to/cert.pem"],
  // "wc": 1,
  // "fsync": false,
  // "bulk": false,
  // "collection_filters": "{}",
  // "read_preference": "Primary"
});

var sink = elasticsearch({
  uri: "http://elasticsearch:9200/harvester-test",
  // "timeout": "10s", // defaults to 30s
  // "aws_access_key": "ABCDEF", // used for signing requests to AWS Elasticsearch service
  // "aws_access_secret": "ABCDEF" // used for signing requests to AWS Elasticsearch service
});

//t.Source(source).Save(sink);
t.Source("source", source).Save("sink", sink);
//t.Source("source", source, "harvester-test.entries").Save(
//  "sink",
//  sink,
//  "harvester-test.entries"
//);
