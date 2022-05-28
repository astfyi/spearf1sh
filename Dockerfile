FROM ubuntu:22.04
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential file curl wget cpio unzip rsync bc git gcc-arm-none-eabi libssl-dev python3 python3-pip

WORKDIR /spearf1sh
COPY . .

WORKDIR /spearf1sh/os/work_artyz7_20_gpio_jtag
RUN make BR2_EXTERNAL=../os/ O=$PWD -C ../../buildroot artyz7_20_gpio_jtag_defconfig && \
    make
