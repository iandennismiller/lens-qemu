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
	-qemu-system-$(QEMU_ARCH) \
		-hda ./hda-$(DEBIAN_ARCH).qcow2 \
		-accel $(HYPERVISOR) \
		-m 2048 \
		-net user,hostfwd=tcp::2222-:22 \
		-net nic \
		-vnc :0 \
		-daemonize

requirements-macos:
	brew install qemu wget

debian:
	qemu-system-$(QEMU_ARCH) \
		-cdrom debian-10.1.0-$(DEBIAN_ARCH)-netinst.iso \
		-boot d \
		-m 1024 \
		-accel $(HYPERVISOR) \
		-hda ./hda-$(DEBIAN_ARCH).qcow2

key:
	ssh-keygen -f ssh/debian -t rsa -b 4096 -C "Debian Lens User"

bootstrap-stage1:
	@echo
	@echo "# Wait for VM to boot"
	@echo "Please enter debian user password when prompted."
	@until ssh -o ConnectTimeout=2 -p 2222 debian@127.0.0.1 "exit" 2>/dev/null; do sleep 1; done
	@echo "Okay.  The VM has booted."

	@echo
	@echo "# Copy stage 1 script"
	@echo "Provide the debian user password to copy the bootstrap script."
	@scp -P2222 bin/bootstrap-stage1.sh debian@127.0.0.1:

	@echo
	@echo "# Execute stage 1 script"
	@echo "First enter the debian user password."
	@echo "Then, provide the root user password."
	@ssh -p2222 -t debian@127.0.0.1 "su - -c '~debian/bootstrap-stage1.sh'"

bootstrap-stage2:
	@echo
	@echo "# Copy stage 2 script"
	@scp -i ssh/debian -P2222 bin/bootstrap-stage2.sh debian@127.0.0.1:

	@echo
	@echo "# Execute stage 2 script"
	@echo "Provide the debian user password to execute the bootstrap script."
	@ssh -i ssh/debian -p2222 -t debian@127.0.0.1 "sudo ~debian/bootstrap-stage2.sh"

bootstrap: run bootstrap-stage1 bootstrap-stage2
	@echo "Done bootstrapping."

hda:
	qemu-img create -f qcow2 hda-$(DEBIAN_ARCH).qcow2 16G

download-image:
	wget http://imiller.utsc.utoronto.ca/media/lens/hda-amd64.qcow2

download-iso:
	wget "https://cdimage.debian.org/debian-cd/current/$(DEBIAN_ARCH)/iso-cd/debian-10.1.0-$(DEBIAN_ARCH)-netinst.iso"

ssh:
	ssh -t -p 2222 -i ssh/debian debian@127.0.0.1

.PHONY: run hda bootstrap download-iso download-image requirements-macos ssh
