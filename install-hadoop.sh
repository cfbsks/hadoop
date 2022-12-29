# install-hadoop.sh
#!/bin/bash

# Check if wget is installed
if ! command -v wget >/dev/null; then
    # Install wget
    dnf update -y
    dnf install -y wget
fi

# Check if variable is set
if [ -z "$HadoopRelease" ]; then
    # Set default value for $HadoopRelease
    HadoopRelease="https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.3.4.tar.gz"
fi

# Extract file name from URL
FileName=$(basename $HadoopRelease)

# Get check sum
# Download HTML page and extract SHA-512 hash
SHA512=$(wget $HadoopRelease.sha512 -O - | grep -o ".\{128\}$")

# Download file using wget
wget $HadoopRelease

# Check sum
if [ "$(sha512sum $FileName)" = "$SHA512  $FileName" ]; then
    echo "Info: SHA-512 hash matches expected value."
else
    echo "Fatal: SHA-512 hash doesn't match expected value."
    exit
fi

# Unpack and mv hadoop
tar zxvf $FileName -C /usr/local/
rm $FileName
mv /usr/local/hadoop* /usr/local/hadoop
