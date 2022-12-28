# install-hadoop.sh
#!/bin/bash

# Check if wget is installed
if ! command -v wget >/dev/null; then
    # Install wget
    dnf update -y
    dnf install -y wget
fi

# Check if variable is set
if [ -z "$HBaseRelease" ]; then
    # Set default value for $HBaseRelease
    HBaseRelease="https://dlcdn.apache.org/hbase/2.4.15/hbase-2.4.15-bin.tar.gz"
fi

# Extract file name from URL
FileName=$(basename $HBaseRelease)

# Download file using wget
wget $HBaseRelease

# Unpack and mv hbase
tar zxvf $FileName -C /usr/local/
rm $FileName
mv /usr/local/hbase* /usr/local/hbase
