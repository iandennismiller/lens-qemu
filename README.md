# lens-qemu

Run Lens inside an x86_64 Debian Buster guest that is hosted by QEMU on MacOS.

To launch on Windows, edit `Makefile` to uncomment `HYPERVISOR=hax`.

## Launching Lens

### Host

```
make run
```

### Connecting to Guest

- username is `idm` and password is `debian`
- root password is also `debian`

#### VNC

Use VNC to connect to the guest display.

```
vncviewer 127.0.0.1:5900
```

#### ssh

`ssh` is available on port 2222:

```
ssh -p2222 idm@127.0.0.1
```

#### scp

Use `scp` to move files to/from the image.

```
scp -P2222 -r Lens-dist/ idm@127.0.0.1:/app/Lens-linux
```

### Inside Guest

Launch a terminal from the dock.
Then, launch Lens.

```
cd /app/Lens-linux
./Bin/lens.sh
```

## Requirements

In order to run a QEMU image, there are several requirements.
The machine you are sitting at is the "host" and the virtual machine is the "guest."

### Host Requirements

Install QEMU and a VNC viewer.

#### MacOS with Homebrew

```
brew install qemu
brew cask install tigervnc-viewer
```

#### HAXM

Intel Hardware Accelerated Extension Manager (HAXM) is required for acceleration on Windows.
HAXM is also required for i386 virtualization on both MacOS and Windows.

- [Download v7.5.4](https://github.com/intel/haxm/releases/tag/v7.5.4)
- [All HAXM releases](https://github.com/intel/haxm/tags)
- [Instructions for MacOS](https://github.com/intel/haxm/wiki/Installation-Instructions-on-macOS)

### Guest Requirements

If you have built your own guest image, the following are useful:

```
apt install build-essential \
    tigervnc-standalone-server \
    net-tools
```

## Guest disk image

There are two ways to obtain a runnable Debian disk image:

1. download a pre-built snapshot
2. build your own

### Using the snapshot

A runnable Debian x86_64 image is available.

```
wget http://imiller.utsc.utoronto.ca/media/lens/hda-amd64.qcow2
```

### Bootstrapping a Debian Buster image

Create your own disk image and install Debian Buster on it.

```
make download
make hda
make bootstrap
make run
```

## References

- http://tedlab.mit.edu/~dr/Lens/installing.html
