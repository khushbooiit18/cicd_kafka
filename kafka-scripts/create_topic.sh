#!/bin/bash
docker exec kafka kafka-topics --create --topic test-topic --bootstrap-server kafka:9092 --replication-factor 1 --partitions 1 || true

