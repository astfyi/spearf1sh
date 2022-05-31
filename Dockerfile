FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y -q \
        bash \
        bc \
        binutils \
        bison \
        bsdmainutils \
        build-essential \
        bzip2 \
        ca-certificates \
        cmake-extras \
        cmake \
        cpio \
        cryptsetup \
        debianutils \
        flex \
        gcc \
        git \
        gnu-efi \
        g++ \
        gzip \
        libelf-dev \
        libncurses5-dev \
        libnss3-tools \
        libpcap-dev \
        libssl-dev \
        locales \
        lzop \
        make \
        patch \
        perl \
        python-dev \
        python \
        qemu-system-x86 \
        rsync \
        sbsigntool \
        sed \
        swig \
        tar \
        unzip \
        wget \
        zlib1g-dev

RUN groupadd -r buildroot && useradd -g buildroot buildroot
COPY --chown=buildroot:buildroot / /home/buildroot
WORKDIR /home/buildroot
USER buildroot
RUN mkdir work
WORKDIR /home/buildroot/work

RUN make BR2_EXTERNAL=/home/buildroot/os O=/home/buildroot/work -C /home/buildroot/buildroot artyz7_20_gpio_jtag_defconfig
RUN make

