pipeline = Source({name:"mongo", tail: true, namespace: "harvester-test.entries"})
  .transform({filename: "transformers/passthrough_and_log.js", namespace: "harvester-test.entries"})
  .save({name:"es", namespace: "harvester-test.entries"})


