#!/bin/bash

# Generate a new key
ssh-keygen -f key/debian -t rsa -b 4096 -C "Debian Lens User"

# Load that key
KEY=$(cat key/debian.pub)

# Remove the old key
sed -i .bak '/^ssh-rsa/d' bin/stage1.sh

# Insert the new key
sed -i .bak -e '/^cat/a\'$'\n'"${KEY}" bin/stage1.sh
