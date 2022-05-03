################################################################################
#
# fsverity-utils
#
################################################################################

FSVERITY_UTILS_VERSION = v1.5
FSVERITY_UTILS_SITE = https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git/snapshot
FSVERITY_UTILS_LICENSE = GPL-2.0+, LGPL-2.1+
FSVERITY_UTILS_LICENSE_FILES = LICENCE.GPL LICENCE.LGPL
FSVERITY_UTILS_INSTALL_STAGING = YES
FSVERITY_UTILS_INSTALL_TARGET = YES

FSVERITY_UTILS_MAKE_PARAMS = \
	INSTALL=$(INSTALL) \
	LIBDIR=/usr/lib \
	USRLIBDIR=/usr/lib \
	CFLAGS="$(TARGET_CFLAGS)" \
	CPPFLAGS="$(TARGET_CPPFLAGS) -I." \
	LNS="$(HOSTLN) -sf"

define FSVERITY_UTILS_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) $(FSVERITY_UTILS_MAKE_PARAMS) -C $(@D)
endef

define FSVERITY_UTILS_INSTALL_STAGING_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) $(FSVERITY_UTILS_MAKE_PARAMS) -C $(@D) DESTDIR=$(STAGING_DIR) install
endef

define FSVERITY_UTILS_INSTALL_TARGET_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) $(FSVERITY_UTILS_MAKE_PARAMS) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
