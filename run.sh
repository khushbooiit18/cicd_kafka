#!/bin/bash

# Create Docker network 
 docker network create kafka-net

# Start containers
docker start zookeeper || docker run -d --name zookeeper --network kafka-net -e ZOOKEEPER_CLIENT_PORT=2181 confluentinc/cp-zookeeper:7.2.1
docker start kafka || docker run -d --name kafka --network kafka-net -e KAFKA_BROKER_ID=1 -e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092 -e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092 -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 -p 9092:9092 confluentinc/cp-kafka:7.2.1

echo "Waiting for Kafka to be ready..."
sleep 20


# Install Python dependencies
pip install -r requirements.txt

# Create topic
bash kafka-scripts/create_topic.sh



# Produce and consume

python3 kafka-scripts/producer.py

python3 kafka-scripts/consumer.py 






