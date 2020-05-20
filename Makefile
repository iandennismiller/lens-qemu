# Makefile for lens-qemu
# 2019 Ian Dennis Miller

# Use "hvf" for MacOS
HYPERVISOR=hvf
# Use the Windows Hypervisor (on Windows 10) if it is available
# HYPERVISOR=whpx
# Use "hax" for Windows and/or i386; requires Intel HAXM (see Readme)
# HYPERVISOR=hax

# RAM size, in MB
RAM=2048

# Image size, in GB
IMAGE_SIZE=256

# Which port should SSH be available on?
SSH_PORT=2222

# DEBIAN_ARCH: Choices are i386 and amd64
DEBIAN_ARCH=amd64

# QEMU_ARCH: Choices are i386 and x86_64
QEMU_ARCH=x86_64

run:
	-qemu-system-$(QEMU_ARCH) \
		-hda ./hda-$(DEBIAN_ARCH).qcow2 \
		-accel $(HYPERVISOR) \
		-m $(RAM) \
		-usb \
		-device usb-tablet \
		-net user,hostfwd=tcp::$(SSH_PORT)-:22 \
		-net nic \
		-vnc :0

ssh:
	ssh -t -p $(SSH_PORT) -i key/debian debian@127.0.0.1

requirements-macos:
	brew install qemu wget

hda:
	qemu-img create -f qcow2 hda-$(DEBIAN_ARCH).qcow2 $(IMAGE_SIZE)G

download-image:
	wget http://imiller.utsc.utoronto.ca/media/lens/hda-amd64.qcow2
	wget -O key/debian http://imiller.utsc.utoronto.ca/media/lens/debian
	wget -O key/debian.pub http://imiller.utsc.utoronto.ca/media/lens/debian.pub

download-iso:
	wget "https://cdimage.debian.org/debian-cd/current/$(DEBIAN_ARCH)/iso-cd/debian-10.1.0-$(DEBIAN_ARCH)-netinst.iso"

debian:
	qemu-system-$(QEMU_ARCH) \
		-cdrom debian-10.1.0-$(DEBIAN_ARCH)-netinst.iso \
		-boot d \
		-m 1024 \
		-accel $(HYPERVISOR) \
		-hda ./hda-$(DEBIAN_ARCH).qcow2

key:
	bin/generate-key.sh

bootstrap: run
	bin/bootstrap.sh $(SSH_PORT)
	@echo "Done bootstrapping."

.PHONY: run hda bootstrap download-iso download-image requirements-macos ssh
