### Bootstrapping a Debian Buster image

Create your own disk image and install Debian Buster on it.

```
make download-iso
make hda
make bootstrap
```

### Guest Requirements

If you have built your own guest image, the following are useful:

```
apt install build-essential \
    tigervnc-standalone-server \
    net-tools
```
