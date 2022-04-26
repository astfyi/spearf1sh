#!/bin/bash

mkdir -p /lib/firmware

cp $1 /lib/firmware

echo 0 > /sys/class/fpga_manager/fpga0/flags
echo "$(basename $1)" > /sys/class/fpga_manager/fpga0/firmware
