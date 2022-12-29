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

COPY start-hadoop.sh /etc/hadoop/
COPY hadoop-env.sh /usr/local/hadoop/etc/hadoop/
COPY profile /etc/profile
COPY init.sh /init.sh

RUN  chmod +x /init.sh /etc/hadoop/start-hadoop.sh

WORKDIR /usr/local/hadoop

COPY core-site.xml etc/hadoop/
COPY hdfs-site.xml etc/hadoop/

EXPOSE 9870

CMD ["bash","/init.sh"]
