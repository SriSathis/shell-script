# Setup a Kafka Cluster with 3 nodes on Centos 7
Apache Kafka is an open source distributed stream processing platform. From a high-level perspective, Kafka is a distributed messaging system that allows producers to send messages to a topic and consumers to read messages from a topic. Kafka is massively scalable and offers high throughput and low latency when operated in a cluster. This post explains how to set up a Kafka cluster consisting of 3 nodes for a development environment.
## Install Java
Download the Java installation script file from Project, and run the script file
## Install Kafka
Downloading Kafka:
[Download Kafka](http://apache.forsale.plus/kafka/2.4.0/kafka_2.11-2.4.0.tgz) and unpack it under /home
```
wget http://apache.forsale.plus/kafka/2.4.0/kafka_2.11-2.4.0.tgz
tar -xzf kafka_2.11-2.4.0.tgz
mv kafka_2.11-2.4.0 kafka
```



