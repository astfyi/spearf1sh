#!/bin/bash

echo "Starting FPGA remote reloader"

echo "Your IP is:"
ifconfig eth0 | grep inet

mkdir -p /lib/firmware/
touch /lib/firmware/reload.bin.bit

echo 0 > /sys/class/fpga_manager/fpga0/flags

socat -d -d -u TCP4-LISTEN:1337,reuseaddr,fork file:/sys/class/fpga_manager/fpga0/firmware &
socat -d -d -u TCP4-LISTEN:1338,reuseaddr,fork file:/lib/firmware/reload.bin.bit &
