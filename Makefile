# Makefile for lens-qemu
# 2019 Ian Dennis Miller

# Use "hvf" for MacOS
HYPERVISOR=hvf
# Use "hax" for Windows and/or i386; requires Intel HAXM (see Readme)
# HYPERVISOR=hax

# DEBIAN_ARCH and QEMU_ARCH also support "i386"
DEBIAN_ARCH=amd64
QEMU_ARCH=x86_64

run:
	qemu-system-$(QEMU_ARCH) \
		-hda ./hda-$(DEBIAN_ARCH).qcow2 \
		-accel $(HYPERVISOR) \
		-m 2048 \
		-net user,hostfwd=tcp::2222-:22 \
		-net nic \
		-vnc :0

requirements-macos:
	brew install qemu wget

bootstrap:
	qemu-system-$(QEMU_ARCH) \
		-cdrom debian-10.1.0-$(DEBIAN_ARCH)-netinst.iso \
		-boot d \
		-m 1024 \
		-accel $(HYPERVISOR) \
		-hda ./hda-$(DEBIAN_ARCH).qcow2

hda:
	qemu-img create -f qcow2 hda-$(DEBIAN_ARCH).qcow2 16G

download-image:
	wget http://imiller.utsc.utoronto.ca/media/lens/hda-amd64.qcow2

download-iso:
	wget "https://cdimage.debian.org/debian-cd/current/$(DEBIAN_ARCH)/iso-cd/debian-10.1.0-$(DEBIAN_ARCH)-netinst.iso"

.PHONY: run hda bootstrap download-iso download-image requirements-macos
