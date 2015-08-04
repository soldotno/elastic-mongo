pipeline = Source({name:"mongo, tail:true"})
  .transform({filename: "transformers/passthrough_and_log.js", namespace: "harvester.entries"})
  .save({name:"es", namespace: "harvester.entries"})
