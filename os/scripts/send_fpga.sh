#!/bin/bash

display_usage() {
    echo "You must have run the server on the board first"
    echo -e "\nUsage: $0 fpga.bit IPADDROFBOARD \n"
}
# if less than two arguments supplied, display usage
if [  $# -le 1 ]
then
    display_usage
    exit 1
fi

# check whether user had supplied -h or --help . If yes display usage
if [[ ( $# == "--help") ||  $# == "-h" ]]
then
    display_usage
    exit 0
fi

if ! command -v bootgen &> /dev/null
then
    echo "add bootgen to path (try $something/work/build/host-bootgen-2019.2/bootgen)"
    exit
fi

if [ ! -f "$(pwd)/$1" ]; then
    echo "$1 must be in the pwd"
    exit
fi


sed -i "3 s/.*/$1/g" reload.bif

if ! [ $? -eq 0 ]
then
    echo "failed to change bif file"
    exit
fi


bootgen -w -image reload.bif -arch zynq -process_bitstream bin

if ! [ $? -eq 0 ]
then
    echo "failed to create bin from bit using bif"
    exit
fi

socat file:$1.bin TCP:$2:1338

if ! [ $? -eq 0 ]
then
    echo "failed to transfer bin file to board"
    exit
fi

echo "reload.bin.bit" | socat - TCP:$2:1337

if ! [ $? -eq 0 ]
then
    echo "failed to tell board to reload"
    exit
fi
