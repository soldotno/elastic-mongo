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
            "host": "127.0.0.1:27018",
            "priority": 1
        },
        {
            "_id": 2,
            "host": "127.0.0.1:27019",
            "priority": 1
        }
    ]
};
rs.initiate(cfg);
rs.reconfig(cfg);
