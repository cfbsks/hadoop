FROM fedora:latest

ENV HadoopRelease="https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.3.4.tar.gz"
ENV Path=value

RUN dnf update -y && \
    dnf install -y java-1.8.0-openjdk-devel && \
    dnf install -y wget openssh-clients openssh-server

COPY install-hadoop.sh /etc/hadoop/

RUN chmod +x /etc/hadoop/install-hadoop.sh
RUN /etc/hadoop/install-hadoop.sh

COPY hadoop-env.sh /etc/hadoop/
COPY start-hadoop.sh /etc/hadoop/

RUN cat /etc/hadoop/hadoop-env.sh >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh

EXPOSE 50070 50075
EXPOSE 8030 8031 8032 8033

WORKDIR /usr/local/hadoop
# ENTRYPOINT ["bash"]

CMD ["/bin/bash"]
