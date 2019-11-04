run:
	qemu-system-x86_64 \
		-accel hvf \
		-m 1024 \
		-hda ./hda.img

bootstrap:
	qemu-system-x86_64 \
		-cdrom debian-10.1.0-amd64-xfce-CD-1.iso \
		-boot d \
		-accel hvf \
		-m 1024 \
		-hda ./hda.img

img:
	qemu-img create hda.img 4G

download:
	wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.1.0-amd64-xfce-CD-1.iso

.PHONY: run img download bootstrap
