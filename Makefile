run:
	qemu-system-i386 \
		-accel hax \
		-m 1024 \
		-hda ./hda.qcow2

bootstrap:
	qemu-system-i386 \
		-cdrom debian-10.1.0-i386-xfce-CD-1.iso \
		-boot d \
		-m 1024 \
		-accel hax \
		-hda ./hda.qcow2

hda:
	qemu-img create -f qcow2 hda.qcow2 16G

download:
	wget https://cdimage.debian.org/debian-cd/current/i386/iso-cd/debian-10.1.0-i386-xfce-CD-1.iso

.PHONY: run hda download bootstrap
