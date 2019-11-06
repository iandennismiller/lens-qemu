# lens-qemu

Run Lens inside a QEMU image.

http://tedlab.mit.edu/~dr/Lens/installing.html

Requires qemu and Intel Hardware Accelerated Extension Manager (HAXM):

https://github.com/intel/haxm/wiki/Installation-Instructions-on-macOS

## Inside the image

```
export LENSDIR=~/Lens
export LD_LIBRARY_PATH=${LENSDIR}/Bin/${HOSTTYPE}
cd ~/Lens
Bin/${HOSTTYPE}/lens-2.63
```
