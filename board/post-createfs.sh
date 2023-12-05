#!/bin/sh

set -e

TARGETDIR=$1
FWUP_CONFIG=$2

BOARD_NAME="zybo_z7_10"

BOOTGEN=$HOST_DIR/bin/bootgen
FWUP=$HOST_DIR/bin/fwup

FW_PATH=$BINARIES_DIR/$BOARD_NAME.fw
IMG_PATH=$BINARIES_DIR/$BOARD_NAME.img

echo "Creating BOOT.BIN..."
cd $BINARIES_DIR
cp -f ${BR2_EXTERNAL_ZYBO_Z7_10_PATH}/board/bootgen.bif .
cp -f ${BR2_EXTERNAL_ZYBO_Z7_10_PATH}/board/zynq_fsbl.elf .
cp -f ${BR2_EXTERNAL_ZYBO_Z7_10_PATH}/board/system.bit .
cp -f ${BR2_EXTERNAL_ZYBO_Z7_10_PATH}/board/system.dtb .
"$BOOTGEN" -arch zynq -image bootgen.bif -w -o BOOT.BIN
cd -

# Build the firmware image (.fw file)
echo "Creating firmware file..."
PROJECT_ROOT=$(pwd) "$FWUP" -c -f "$FWUP_CONFIG" -o "$FW_PATH"

# Build a raw image that can be directly written to
# an SDCard (remove an exiting file so that the file that
# is written is of minimum size. Otherwise, fwup just modifies
# the file. It will work, but may be larger than necessary.)
echo "Creating raw SDCard image file..."
rm -f "$IMG_PATH"
"$FWUP" -a -d "$IMG_PATH" -i "$FW_PATH" -t complete
