#!/bin/bash
# Boostrap a fresh Debian system for Lens.

SSH_PORT=$1

ssh-keygen -R [127.0.0.1]:${SSH_PORT}

echo
echo "Wait for VM to boot"
echo "-------"
echo "Please enter debian user password when prompted."
until ssh -o ConnectTimeout=2 -p ${SSH_PORT} debian@127.0.0.1 "exit" 2>/dev/null; do echo -n "." && sleep 1; done
echo "Okay.  The VM has booted."

echo
echo "Copy stage 1 script"
echo "-------"
echo "Provide the user password to copy the bootstrap script."
scp -P${SSH_PORT} bin/stage1.sh debian@127.0.0.1:

echo
echo "Execute stage 1 script"
echo "-------"
echo "First enter the user password."
echo "Then, provide the root password."
ssh -p${SSH_PORT} -t debian@127.0.0.1 "su - -c '~debian/stage1.sh'"

echo
echo "Copy stage 2 script"
echo "-------"
scp -i key/debian -P${SSH_PORT} bin/stage2.sh debian@127.0.0.1:

echo
echo "Execute stage 2 script"
echo "-------"
echo "Provide the user password to execute the bootstrap script."
ssh -i key/debian -p${SSH_PORT} -t debian@127.0.0.1 "sudo ~debian/stage2.sh"

echo
echo "Wait 5 seconds for VM to shut down"
echo "-------"
sleep 5

echo
echo "Repack qcow2 image"
echo "-------"
qemu-img convert -O qcow2 -c hda-amd64.qcow2 hda-amd64-compressed.qcow2
mv hda-amd64-compressed.qcow2 hda-amd64.qcow2
