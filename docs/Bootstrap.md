### Bootstrapping a Debian Buster image

Create your own disk image and install Debian Buster on it.

```
make download-iso-64
make hda-64
make bootstrap-64
```

### Guest Requirements

If you have built your own guest image, the following are useful:

```
apt install build-essential \
    tigervnc-standalone-server \
    net-tools
```
