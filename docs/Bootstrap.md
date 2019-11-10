# Bootstrapping a Debian Buster image

You can create your own Virtual Machine and install Lens on it.

Edit `Makefile` to configure RAM, disk size, architectures, and hypervisor.

## Quick Bootstrap

```
make download-iso
make hda
make debian
make bootstrap
```

## Step-by-step Bootstrap

### 1. Download the Debian Buster net install ISO

```
make download-iso
```

### 2. Create a disk image using the QCOW2 format

```
make hda
```

### 3. Boot the VM and install Debian from the ISO

```
make debian
```

### 4. Boot the new VM and configure it with `bin/bootstrap.sh`

```
make bootstrap
```

There are two stages to the bootstrapping process:

- `bin/stage1.sh`: the user is created and given superuser access.
- `bin/stage2.sh`: the application (Lens) is installed and configured.

The `bootstrap.sh` script runs on the host machine, while `stage1.sh` and `stage2.sh` run *inside* the virtual machine.

## Changing the SSH key

You can use your own SSH key instead of the one hardcoded in the repo.

```
make key
```
