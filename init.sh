# /init.sh
#!/bin/bash

# Generate ssh-keys
ssh-keygen -A
ssh-keygen -t rsa -b 4096
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Start SSHD service
/usr/sbin/sshd

# Load /etc/profile
source /etc/profile

# Run a shell
/bin/bash
