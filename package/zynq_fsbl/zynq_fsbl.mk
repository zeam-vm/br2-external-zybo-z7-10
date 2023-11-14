################################################################################
#
# zynq_fsbl
#
################################################################################

ZYNQ_FSBL_VERSION = xilinx_v2022.1
ZYNQ_FSBL_SITE = $(call github,Xilinx,embeddedsw,$(ZYNQ_FSBL_VERSION))
ZYNQ_FSBL_LICENSE = GPL-2.0+ MIT
ZYNQ_FSBL_LICENSE_FILES = license.txt
ZYNQ_FSBL_DEPENDENCIES += host-arm-gnu-toolchain
ZYNQ_FSBL_INSTALL_TARGET = NO
ZYNQ_FSBL_INSTALL_IMAGES = YES

define ZYNQ_FSBL_BUILD_CMDS
  $(TARGET_MAKE_ENV) $(MAKE1) -C $(@D)/lib/sw_apps/zynq_fsbl/src
endef

define ZYNQ_FSBL_INSTALL_IMAGES_CMDS
  $(INSTALL) -m 0644 -t $(BINARIES_DIR) \
  $(@D)/lib/sw_apps/zynq_fsbl/src/fsbl.elf
endef

$(eval $(generic-package))
