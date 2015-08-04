pipeline = Source({name:"mongo", tail: true, namespace: "harvester.entries"})
  .transform({filename: "transformers/passthrough_and_log.js", namespace: "harvester.entries"})
  .save({name:"es", namespace: "harvester.entries"})


