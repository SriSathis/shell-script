# Setup a Kafka Cluster with 3 nodes on Centos 7
Apache Kafka is an open source distributed stream processing platform. From a high-level perspective, Kafka is a distributed messaging system that allows producers to send messages to a topic and consumers to read messages from a topic. Kafka is massively scalable and offers high throughput and low latency when operated in a cluster. This post explains how to set up a Kafka cluster consisting of 3 nodes for a development environment.
## Install Java
Download the Java installation script file from Project, and run the script file
## Install Kafka
### Downloading Kafka:
[Download Kafka](http://apache.forsale.plus/kafka/2.4.0/kafka_2.11-2.4.0.tgz) and unpack it under /home
```
wget http://apache.forsale.plus/kafka/2.4.0/kafka_2.11-2.4.0.tgz
tar -xzf kafka_2.11-2.4.0.tgz
mv kafka_2.11-2.4.0 kafka
```
On each node create a zookeeper directory and a file ‚myid‘ with a unique number:
```
mkdir /home/kafka/zookeeper/data/myid
echo '1' > /home/kafka/zookeeper/data/myid
```
On all three Server go to Kafka home folder **/home/kafka** and setup zookeeper like this
> vi config/zookeeper.properties
```
# the directory where the snapshot is stored.
dataDir=/home/kafka/zookeeper/data
# the port at which the clients will connect
clientPort=2181
#clientPortAddress=0.0.0.0
# disable the per-ip limit on the number of connections since this is a non-production config
maxClientCnxns=0
 
# The number of milliseconds of each tick
tickTime=2000
  
# The number of ticks that the initial synchronization phase can take
initLimit=10
  
# The number of ticks that can pass between 
# sending a request and getting an acknowledgement
syncLimit=5
 
# zoo servers
server.1=kafka1:2888:3888
server.2=kafka2:2888:3888
server.3=kafka3:2888:3888
#add here more servers if you want
```
Start Zookeeper on all three servers with **daemon** mode
```
./bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
```
Change the Kafka server.properties on all three servers (set a unique broker id on each server)
> vi config/server.properties
```
# The id of the broker. This must be set to a unique integer for each broker.
broker.id=2
 
#     listeners = PLAINTEXT://your.host.name:9092
listeners=PLAINTEXT://:9092
 
# A comma seperated list of directories under which to store log files
log.dirs=/tmp/kafka-logs-2
 
# Zookeeper connection string (see zookeeper docs for details).
# This is a comma separated host:port pairs, each corresponding to a zk
# server. e.g. "127.0.0.1:3000,127.0.0.1:3001,127.0.0.1:3002".
# You can also append an optional chroot string to the urls to specify the
# root directory for all kafka znodes.
zookeeper.connect=kafka1.fritz.box:2181,kafka2.fritz.box:2181,kafka3.fritz.box
```
Start Kafka on all three nodes with **daemon** mode:
```
./bin/kafka-server-start.sh -daemon config/server.properties
```


### Verify Kafka and Zookeper are running:
> jps
```
1173 Jps
27510 Kafka
26878 QuorumPeerMain
```
### Verify also all brokers are registered to zookeeper:
> bin/zookeeper-shell.sh server4:2181 ls /brokers/ids
```
Connecting to server4:2181

WATCHER::

WatchedEvent state:SyncConnected type:None path:null
[1, 2, 3]
```
