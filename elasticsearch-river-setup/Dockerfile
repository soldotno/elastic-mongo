FROM gliderlabs/alpine:3.1
USER root
RUN echo "Will execute: curl ${RIVER_MAPPING} -O mapping.json && " \
          "curl http://es:9200/_river/${RIVER_NAME}/_meta -d @mapping.json" && apk --update add curl

CMD curl ${RIVER_MAPPING} -o mapping.json && \
    curl http://${es}:9200/_river/${RIVER_NAME}/_meta -d @mapping.json
