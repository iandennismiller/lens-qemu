# Makefile for lens-qemu
# 2019 Ian Dennis Miller

HYPERVISOR=hvf
# HYPERVISOR=hax # for Windows; requires Intel HAXM (see Readme)

run:
	qemu-system-x86_64 \
		-accel $(HYPERVISOR) \
		-m 2048 \
		-net user,hostfwd=tcp::2222-:22 \
		-net nic \
		-vnc :0 \
		-hda ./hda-amd64.qcow2

download-image:
	wget http://imiller.utsc.utoronto.ca/media/lens/hda-amd64.qcow2

bootstrap-64:
	qemu-system-x86_64 \
		-cdrom debian-10.1.0-amd64-xfce-CD-1.iso \
		-boot d \
		-m 2048 \
		-accel $(HYPERVISOR) \
		-hda ./hda-amd64.qcow2

hda-64:
	qemu-img create -f qcow2 hda-amd64.qcow2 16G

download-iso-64:
	wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.1.0-amd64-xfce-CD-1.iso

run-i386:
	qemu-system-i386 \
		-accel hax \
		-m 1024 \
		-hda ./hda.qcow2

bootstrap-i386:
	qemu-system-i386 \
		-cdrom debian-10.1.0-i386-xfce-CD-1.iso \
		-boot d \
		-m 1024 \
		-accel hax \
		-hda ./hda.qcow2

hda-i386:
	qemu-img create -f qcow2 hda.qcow2 16G

download-i386:
	wget https://cdimage.debian.org/debian-cd/current/i386/iso-cd/debian-10.1.0-i386-xfce-CD-1.iso

.PHONY: run hda download bootstrap run-i386 hda-i386 download-i386 bootstrap-i386
