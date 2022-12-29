# /etc/hadoop/start-hadoop.sh
#!/bin/bash

bin/hdfs namenode -format
sbin/start-dfs.sh

# hadoop yarn resourcemanager
# hadoop yarn nodemanager
