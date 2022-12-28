# /etc/hadoop/start-hadoop.sh
#!/bin/bash

hadoop namenode -format
hadoop datanode
# hadoop yarn resourcemanager
# hadoop yarn nodemanager
