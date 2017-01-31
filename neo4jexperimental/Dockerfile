FROM neo4j:3.1
MAINTAINER James G. Kim <jgkim@jayg.org>

ENV NEO4J_PLUGINS_PATH /var/lib/neo4j/plugins/

ENV NEO4J_APOC_FILE apoc-3.1.0.3-all.jar
ENV NEO4J_APOC_URI https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/3.1.0.3/apoc-3.1.0.3-all.jar

RUN curl --fail --silent --show-error --location --output $NEO4J_APOC_FILE $NEO4J_APOC_URI \
  && mv $NEO4J_APOC_FILE $NEO4J_PLUGINS_PATH
