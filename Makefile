run:
	qemu-system-x86_64 \
		-accel hvf \
		-m 2048 \
		-net user,hostfwd=tcp::2222-:22 \
		-net nic \
		-daemonize \
		-vnc :0 \
		-hda ./hda-amd64.qcow2

bootstrap:
	qemu-system-x86_64 \
		-cdrom debian-10.1.0-amd64-xfce-CD-1.iso \
		-boot d \
		-m 2048 \
		-accel hvf \
		-hda ./hda-amd64.qcow2

hda:
	qemu-img create -f qcow2 hda-amd64.qcow2 16G

download:
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
