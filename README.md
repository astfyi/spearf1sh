# Spearf1sh

Spearf1sh Embedded Hacking Tool and Distro

## Quick start

```shellsession
wget https://raw.githubusercontent.com/astfyi/spearf1sh/main/os/scripts/installer.sh -O - | bash
```

This might take up to 2 hours.


If successful the sd card image is in `$HOME/spearf1sh/work/images/sdcard.img`.

## Overview

Spearf1sh is largely built around the Zynq and Pynq development boards, which are Xilinx Zynq 7020-based ARM Cortex-A SoCs with an FPGA. This allows for embedded linux to run on the hard-core ARM and the FPGA to handle whatever you like.

Buildroot is the embedded linux build platform tool of choice. However, due to the fact that _you_ change the hardware in a FGPA, to buildroot, this looks like you have made a new "board." Which, kinda, you did.

## Spearf1sh Compatible Platforms

The Spearf1sh Linux has been tested and is supported by the following Xilinx Zynq 7020 based platforms. These can be purchased via multiple vendors and are regularly available on the [Digilent store](https://digilent.com/shop/pynq-z1-python-productivity-for-zynq-7000-arm-fpga-soc/), [Digikey](https://www.digikey.com/en/products/detail/digilent-inc/6003-410-017/9839382), Farnell and Element 14, [Mouser](https://eu.mouser.com/ProductDetail/Digilent/6003-410-017?qs=W0yvOO0ixfGf/od50nO3UQ%3D%3D) and sometimes on Amazon, Ebay and Aliexpress.
1. [Digilent Pynq Z1](https://digilent.com/shop/pynq-z1-python-productivity-for-zynq-7000-arm-fpga-soc/) (Recommended)
2. [Digilent Arty Zynq Z7-20](https://www.xilinx.com/products/boards-and-kits/1-pdb0q2.html]) (only the Arty Z7-20 is supported, the Arty Z7-10 is not!)
3. [TUL Pynq Z2](https://www.tulembedded.com/FPGA/ProductsPYNQ-Z2.html)

## Default username and password

`root:f1sh!`

Don't raspberry pi me.

## Building/Rebuilding/Updating

If you need to rebuild the default spearf1sh image, without starting from scratch, run the installer script with `-x`.

### Buildroot download cache

By default the installer will download the open source buildroot packages to `$HOME/.spearf1sh/buildroot_dl`. The download cache is not removed by default to increase build time. You must manually delete if you want to reclaim the storage.

### Storage

Speaking of storage, have at least 20GB of space to do more, but why stop there? Spearf1sh might grow, so get some more. But 20 might be fine, for now.
