# spearf1sh
Spearf1sh Embedded Hacking Tool

## Quick start

```shellsession
wget https://raw.githubusercontent.com/advancedsecio/spearf1sh/main/os/scripts/installer.sh -O - | bash
```

This might take up to 2 hours.


If successful the sd card image is in `$HOME/spearf1sh/work/images/sdcard.img`.


### Rebuilding

If you need to rebuild the default spearf1sh image, without starting from scratch, run the installer script with `-x`.

### Buildroot download cache

By default the installer will download the open source buildroot packages to `$HOME/.spearf1sh/buildroot_dl`. The download cache is not removed by default to increase build time. You must manually delete if you want to reclaim the storage.

### Storage

Speaking of storage, have at least 20GB of space to do more, but why stop there? Spearf1sh might grow, so get some more. But 20 might be fine, for now.

## Default username and password

`root:f1sh!`

Don't raspberry pi me.

## Overview

Spearf1sh is largely built around Digilent's Arty Zynq platform, which is a ARM Cortex-A SoC with a FPGA. This allows for embedded linux to run on the hard-core ARM and the FPGA to handle whatever you like.

Buildroot is the embedded linux build platform tool of choice. However, due to the fact that _you_ change the hardware in a FGPA, to buildroot, this looks like you have made a new "board." Which, kinda, you did.
