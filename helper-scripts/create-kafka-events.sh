#!/bin/bash

INPUT_DATA=data/tpcds_data_5g_streaming/streaming_data_after_2002/d_date_2003-01-02.csv
KAFKA_HOME=/path/to/kafka/home
TOPIC=bigspark-streaming
KAFKA_HOSTNAME=localhost
KAFKA_PORT=9093

# Check kafka is installed / kafka-console-producer is available
if [[ ! -f "${KAFKA_HOME}/bin/kafka-console-producer2.sh" ]]; then
    echo "'${KAFKA_HOME}/bin/kafka-console-producer.sh' not found: is Kafka installed? Is the KAFKA_HOME value '${KAFKA_HOME}' set correctly?"
fi

# Create events
trap "exit" INT
while IFS= read -r line
do
  echo "$line" | ${KAFKA_HOME}/bin/kafka-console-producer.sh --topic ${TOPIC} --bootstrap-server ${kafka_hostname}:${KAFKA_PORT}
  sleep 1
done < "$INPUT_DATA"
