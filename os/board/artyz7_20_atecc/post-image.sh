#!/bin/sh

BOARD_DIR="$(dirname $0)"
mkimage=$HOST_DIR/bin/mkimage
bootgen=$HOST_DIR/bin/bootgen

cp ${BOARD_DIR}/image.its ${BINARIES_DIR}/image.its
cp ${BOARD_DIR}/fsbl.elf ${BINARIES_DIR}/fsbl.elf
cp ${BOARD_DIR}/fpga.bit ${BINARIES_DIR}/fpga.bit
cp ${BOARD_DIR}/boot.bif ${BINARIES_DIR}/boot.bif

(cd ${BINARIES_DIR}; bootgen -image boot.bif -arch zynq -o BOOT.bin -w on)

$mkimage -f ${BINARIES_DIR}/image.its -r ${BINARIES_DIR}/image.fit

support/scripts/genimage.sh -c ${BOARD_DIR}/genimage.cfg
