################################################################################
#
# python-spearf1sh-api-server
#
################################################################################
PYTHON_SPEARF1SH_API_SERVER_VERSION = 1
PYTHON_SPEARF1SH_API_SERVER_SITE_METHOD = local
PYTHON_SPEARF1SH_API_SERVER_SITE = $(PYTHON_SPEARF1SH_API_SERVER_PKGDIR)/app
PYTHON_SPEARF1SH_API_SERVER_LICENSE = Apache-2.0 GPL-3.0-or-later BSD-4-Clause-UC OpenSSL CC0-1.0 MIT-like
PYTHON_SPEARF1SH_API_SERVER_LICENSE_FILES = LICENSE
PYTHON_SPEARF1SH_API_SERVER_INSTALL_STAGING = NO
PYTHON_SPEARF1SH_API_SERVER_INSTALL_TARGET = YES
PYTHON_SPEARF1SH_API_SERVER_DEPENDENCIES = python-flask

define PYTHON_SPEARF1SH_API_SERVER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0700 $(PYTHON_SPEARF1SH_API_SERVER_PKGDIR)/app/spearf1sh-api-server.py $(TARGET_DIR)/usr/local/bin/spearf1sh-api-server.py
	$(INSTALL) -D -m 0700 $(PYTHON_SPEARF1SH_API_SERVER_PKGDIR)/app/reconfigure_full_bitstream.sh $(TARGET_DIR)/usr/local/bin/reconfigure_full_bitstream.sh
endef

define PYTHON_SPEARF1SH_API_SERVER_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(PYTHON_SPEARF1SH_API_SERVER_PKGDIR)/spearf1sh-api.service $(TARGET_DIR)/usr/lib/systemd/system/spearf1sh-api.service
endef

$(eval $(generic-package))
