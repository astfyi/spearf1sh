# spearf1sh
Spearf1sh Embedded Hacking Tool

## Quick start

1. `git clone --recurse-submodules -j8 git@github.com:advancedsecio/spearf1sh.git`
2. `cd spearf1sh/os`
3. `mkdir work_artyz7_20_gpio_jtag && cd work_artyz7_20_gpio_jtag/` (this is your "work" directory)
4. `make BR2_EXTERNAL=../os/ O=$PWD -C ../../buildroot artyz7_20_gpio_jtag_defconfig`
5. `make` (this will take a while)

If successful the sd card image is in `images/sdcard.img`.


## Changing the bitstream on the sd card

This is a complicated topic, but assuming you didn't not change the linux/uboot device tree and all the hardware associated with it, then you need to replace the board/<name_of_board>/fpga.bit and images/fpga.bit with your new bitstream, then type make from your work directory.


To clone, do:

```
git clone --recurse-submodules -j8 git@github.com:advancedsecio/spearf1sh.git
```

## Overview

Spearf1sh is largely built around Digilent's Arty Zynq platform, which is a ARM Cortex-A SoC with a FPGA. This allows for embedded linux to run on the hard-core ARM and the FPGA to handle whatever you like.

Buildroot is the embedded linux build platform tool of choice. However, due to the fact that _you_ change the hardware in a FGPA, to buildroot, this looks like you have made a new "board." Which, kinda, you did.

For each config you want to build, what you should do is make a `work_*` directory under `os`. This directory will be git ignored. Then cd into that work directory. Then type the following incantation:

``` shell
user@system s/o/work_artyz7_20> make BR2_EXTERNAL=../ O=$PWD -C ../../buildroot artyz7_20_defconfig
```

Then, type `make` and wait a long time.
