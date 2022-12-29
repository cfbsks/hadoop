export HADOOP_OS_TYPE=${HADOOP_OS_TYPE:-$(uname -s)}

# manual
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export HADOOP_CLASSPATH=$JAVA_HOME/lib/tools.jar
export HDFS_NAMENODE_USER=root
export HDFS_DATANODE_USER=root
export HDFS_SECONDARYNAMENODE_USER=root
export YARN_RESOURCEMANAGER_USER=root
export YARN_NODEMANAGER_USER=root