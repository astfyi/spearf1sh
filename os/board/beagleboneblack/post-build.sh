#!/bin/sh
BOARD_DIR="$(dirname $0)"

cp $BOARD_DIR/uEnv.txt $BINARIES_DIR/uEnv.txt

support/scripts/genimage.sh -c ${BOARD_DIR}/genimage.cfg
