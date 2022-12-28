FROM fedora:latest

ARG HadoopRelease="https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.3.4.tar.gz"

RUN dnf update -y && \
    dnf install -y java-1.8.0-openjdk-devel \
    wget \
    openssh-clients  \
    openssh-server  \
    net-tools \
    && dnf clean all

COPY install-hadoop.sh /etc/hadoop/
RUN chmod +x /etc/hadoop/install-hadoop.sh
RUN /etc/hadoop/install-hadoop.sh

# COPY start-hadoop.sh /etc/hadoop/
COPY hadoop-env.sh /usr/local/hadoop/etc/hadoop/

COPY core-site.xml etc/hadoop/
COPY hdfs-site.xml etc/hadoop/

ARG HBaseRelease="https://dlcdn.apache.org/hbase/2.4.15/hbase-2.4.15-bin.tar.gz"

COPY install-hbase.sh /etc/hbase/
RUN chmod +x /etc/hbase/install-hbase.sh
RUN /etc/hbase/install-hbase.sh

# COPY start-habase.sh /etc/hbase/
COPY hbase-env.sh /usr/local/hbase/conf/

COPY profile /etc/profile

COPY init.sh /init.sh
RUN  chmod +x /init.sh

WORKDIR /usr/local/hbase

EXPOSE 16010

CMD ["bash","/init.sh"]
