################################################################################
#
# tpm-simulator
#
################################################################################
TPM_SIMULATOR_VERSION = 1.0.0
TPM_SIMULATOR_SITE_METHOD = local
TPM_SIMULATOR_SITE = ${TPM_SIMULATOR_PKGDIR}/services
TPM_SIMULATOR_LICENSE = Apache-2.0 GPL-3.0-or-later BSD-4-Clause-UC OpenSSL CC0-1.0 MIT-like
TPM_SIMULATOR_LICENSE_FILES = LICENSE
TPM_SIMULATOR_INSTALL_STAGING = NO
TPM_SIMULATOR_INSTALL_TARGET = YES

define TPM_SIMULATOR_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/tpm-server.service $(TARGET_DIR)/usr/lib/systemd/system/tpm-server.service
	$(INSTALL) -D -m 0644 $(@D)/tpm2-abrmd.service $(TARGET_DIR)/usr/lib/systemd/system/tpm2-abrmd.service
endef

$(eval $(generic-package))
