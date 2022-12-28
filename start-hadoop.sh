# start-hadoop.sh
#!/bin/bash

/sshd -D
hadoop namenode -format
hadoop datanode
# hadoop yarn resourcemanager
# hadoop yarn nodemanager
