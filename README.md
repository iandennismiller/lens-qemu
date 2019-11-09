# lens-qemu

This project provides a Debian Linux Virtual Machine disk image that has Lens pre-installed in `/app/Lens-linux`.
This image can be virtualized with QEMU.

## Quick Start

1. Clone this project
2. Install requirements
3. Download and run the Virtual Machine
4. Connect to the Virtual Machine using VNC
5. Login to the Virtual Machine
6. Launch Lens

### 1. Clone this project

First, clone this repository.

```
git clone https://projects.sisrlab.com/cap-lab/lens-qemu.git
cd lens-qemu
```

### 2. Install requirements

`lens-qemu` requires QEMU and `wget` to work.
You can install these on MacOS with homebrew using `make requirements-mac`.

```
make requirements-mac
```

See [Windows Requirements](docs/Windows.md) for compatiblity with Win10.

### 3. Download and run the Virtual Machine

1. Download the VM disk image with `make download-image`.
2. Run the VM with `make run`.

```
make download-image
make run
```

### 4. Connect to the Virtual Machine using VNC

Use your favorite VNC client to connect to `127.0.0.1:5900`.

If you do not have any VNC client yet, [install Tiger VNC](docs/VNC.md).

### 5. Login to the Virtual Machine

- username is `idm` and password is `debian`
- root password is also `debian`

### 6. Launch Lens

Launch a terminal from the dock.
Then, launch Lens.

```
cd /app/Lens-linux
./Bin/lens.sh
```

## Common tasks

### ssh

`ssh` is available on port 2222:

```
ssh -p2222 idm@127.0.0.1
```

### scp

Use `scp` to move files to/from the image.

```
scp -P2222 -r Lens-dist/ idm@127.0.0.1:/app/Lens-linux
```

## References

- [Instructions for Bootstrapping a new disk image](docs/Bootstrap.md)
- http://tedlab.mit.edu/~dr/Lens/installing.html
