################################################################################
#
# python-cryptoauthlib
#
################################################################################

PYTHON_CRYPTOAUTHLIB_VERSION = v3.3.3
PYTHON_CRYPTOAUTHLIB_SITE_METHOD = git
PYTHON_CRYPTOAUTHLIB_SITE = git@github.com:MicrochipTech/cryptoauthlib.git
PYTHON_CRYPTOAUTHLIB_LICENSE = EPL-1.0 or BSD-3-Clause
PYTHON_CRYPTOAUTHLIB_LICENSE_FILES = license.txt
PYTHON_CRYPTOAUTHLIB_INSTALL_STAGING = NO
PYTHON_CRYPTOAUTHLIB_INSTALL_TARGET = YES
PYTHON_CRYPTOAUTHLIB_DEPENDENCIES = cryptoauthlib
PYTHON_CRYPTOAUTHLIB_SETUP_TYPE = setuptools
PYTHON_CRYPTOAUTHLIB_SUBDIR = python

define PYTHON_CRYPTOAUTHLIB_LN_LIBRARY
	ln -s /usr/lib/libcryptoauth.so $(TARGET_DIR)/usr/lib/python3.9/site-packages/cryptoauthlib/
endef
PYTHON_CRYPTOAUTHLIB_POST_INSTALL_TARGET_HOOKS += PYTHON_CRYPTOAUTHLIB_LN_LIBRARY

$(eval $(python-package))
