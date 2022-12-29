# /init.sh
#!/bin/bash

# Generate ssh-keys
ssh-keygen -A
ssh-keygen -t rsa -b 4096 -N "" -f /root/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Start SSHD service
/usr/sbin/sshd

# Load /etc/profile
source /etc/profile

# Start DFS
/etc/hadoop/start-hadoop.sh

# Run a shell
/bin/bash
