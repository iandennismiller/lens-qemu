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

```
vncviewer 127.0.0.1:5900
```

ssh is available on port 2222:

```
ssh -p2222 idm@127.0.0.1
scp -p2222 -r Lens-dist/ idm@127.0.0.1:/app
```

### Inside Guest

Launch a terminal from the dock.

```
cd /app/Lens-linux
./Bin/lens.sh
```

## Requirements

### Using the snapshot

A runnable Debian x86_64 image is available.

```
wget http://imiller.utsc.utoronto.ca/media/lens/hda-amd64.qcow2
```

### Host

```
brew install qemu
brew cask install tigervnc-viewer
```

Intel Hardware Accelerated Extension Manager (HAXM) is required for acceleration on Windows.
HAXM is also required for i386 virtualization on both MacOS and Windows.

- [Download v7.5.4](https://github.com/intel/haxm/releases/tag/v7.5.4)
- [All HAXM releases](https://github.com/intel/haxm/tags)
- [Instructions for MacOS](https://github.com/intel/haxm/wiki/Installation-Instructions-on-macOS)

### Guest

```
apt install build-essential \
    tigervnc-standalone-server \
    net-tools
```

### Bootstrapping your own image

```
make download
make bootstrap
make run
```

## References

- http://tedlab.mit.edu/~dr/Lens/installing.html
