from kafka import KafkaConsumer

consumer = KafkaConsumer(
    'test-topic',
    bootstrap_servers='localhost:9092',
    auto_offset_reset='from-beginning',
    group_id='test-group'
)

for message in consumer:
    print(f"Consumed: {message.value.decode('utf-8')}")

