#!/bin/bash

sudo apt update \
    && sudo apt upgrade -y \
    && sudo apt autoremove -y \
    && sudo apt install -y libncurses-dev \
	    git libssl-dev autotools-dev autoconf \
	    libtool pkg-config libglib2.0-dev  \
	    picocom libreadline-dev \
	    apt-transport-https \
	    ca-certificates \
	    curl tree \
	    gnupg-agent \
	    software-properties-common \
    && sudo usermod -a -G dialout student

wget https://raw.githubusercontent.com/cryptotronix/puka-buildroot/master/scripts/readline.pc
sudo mv readline.pc /usr/share/pkgconfig/readline.pc

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io


TRAINING_DIR=~/Desktop/training
WORK_DIR=$TRAINING_DIR/work
BUILDROOT_DIR=$TRAINING_DIR/buildroot
VIVADO_PROJECT_DIR=$TRAINING_DIR/vivado
VITIS_PROJECT_DIR=$TRAINING_DIR/vitis
PUKA_BUILDROOT_DIR=$TRAINING_DIR/puka-buildroot

echo "export TRAINING_DIR=$TRAINING_DIR" >> ~/.profile
echo "export WORK_DIR=$WORK_DIR" >> ~/.profile
echo "export BUILDROOT_DIR=$BUILDROOT_DIR" >> ~/.profile
echo "export VIVADO_PROJECT_DIR=$VIVADO_PROJECT_DIR" >> ~/.profile
echo "export VITIS_PROJECT_DIR=$VITIS_PROJECT_DIR" >> ~/.profile
echo "export PUKA_BUILDROOT_DIR=$PUKA_BUILDROOT_DIR" >> ~/.profile

mkdir -p $TRAINING_DIR $WORK_DIR $VIVADO_PROJECT_DIR $VITIS_PROJECT_DIR

cd $TRAINING_DIR

git clone https://github.com/cryptotronix/puka-buildroot.git
git clone https://github.com/buildroot/buildroot.git

cd $BUILDROOT_DIR
git checkout tags/2020.02.1 -b training

cd $WORK_DIR

make BR2_EXTERNAL=$PUKA_BUILDROOT_DIR O=$PWD -C $BUILDROOT_DIR artyz7_20_defconfig
