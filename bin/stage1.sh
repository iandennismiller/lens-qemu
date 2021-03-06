#!/bin/bash
# Boostrap a fresh Debian system for Lens.
# This script must be executed as root.
# Stage 1: User management

# Add debian user to sudoers
/usr/sbin/usermod -aG sudo debian

# Install public key
if [ ! -d ~debian/.ssh ]; then
    mkdir ~debian/.ssh
fi

cat << EOF > ~debian/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDdErQs0ZFKnorElG4NYnJudqFXj+ZTgtLmrOAoBM5WKww/rSTuSsDiVSf6AeYALak8v1h6cP+4JnjCZMituszeL3BH6s/PjwViGEDQ7MEUTaZUOwxU7UimUPHWmRWv9ZUi1PqYfF5bKG3I9CjwXZIGSGlYPLlKM9Y4bPVqw2KQEG2oeU4XRUULGVMLXNG/tpJV5vA29QexVEX36z+uBIO1abM6Zyooq6RyYAN0HIyJRxMgw8fho+pDUxTXM+TJlNv/gloZbKp+FUqs12Fn/rlR7qZ5jH3ul2kinunpIRfViF4JaoZSGYNIr1+nj8QZgedtasxMcMKdw+DMmZsGSBpMjm0b6CTX8cBJp3HUSeRgI7i1fbdsBD6inYfFAtGh0HlbHfs5tXaX+aTuWhrX6iyyNL1ufalvoqF1wE2bs+FfIIjtOoPQAjFGlbI72dmmSJdygQIN1fNVacUre9eRQ0MpYOUtdbePHb+oA5sEGfDlMIDKvopjL0Y+BLBccwxKrQWR4RkSQsHXQNQ2npzZxH1F9E7yHuAccF+FDUSCPPkLfLL6BDBmtuB4IAigU6eiJccuhxfcDTOxUx2a9NlwtQHgzzZyuURNIoQPWkzzJZG5IBplqFha6TzZQ0rkVly6HMmB6piKnhzhXjM57LmWletO92v1oFXQIl8o2RVj5y3Cww== Debian Lens User
EOF

chown -R debian:debian ~debian/.ssh
