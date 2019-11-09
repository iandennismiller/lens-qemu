#!/bin/bash
# Boostrap a fresh Debian system for Lens.
# This script must be executed as root.
# Stage 2: Applications

# Install packages
apt -y install \
    build-essential \
    tigervnc-standalone-server \
    net-tools \
    git

# Install Lens
mkdir -p /app
cd /app
git clone https://projects.sisrlab.com/cap-lab/lens
mv lens Lens-linux
chown -R debian:debian Lens-linux

cd /app/Lens-linux/Bin
rm lens alens
ln -s lens-2.63 lens
ln -s alens-2.63 alens

# Trim filesystem
fstrim -av
