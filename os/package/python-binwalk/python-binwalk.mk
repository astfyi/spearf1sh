################################################################################
#
# python-binwalk
#
################################################################################

PYTHON_BINWALK_VERSION = v2.3.3
PYTHON_BINWALK_SITE_METHOD = git
PYTHON_BINWALK_SITE = git@github.com:ReFirmLabs/binwalk.git
PYTHON_BINWALK_LICENSE = MIT
PYTHON_BINWALK_LICENSE_FILES = LICENSE
PYTHON_BINWALK_INSTALL_STAGING = NO
PYTHON_BINWALK_INSTALL_TARGET = YES
PYTHON_BINWALK_SETUP_TYPE = setuptools


$(eval $(python-package))
$(eval $(host-python-package))
