################################################################################
#
# python-litex
#
################################################################################

PYTHON_LITEX_VERSION = 2022.12
PYTHON_LITEX_SITE_METHOD = git
PYTHON_LITEX_SITE = https://github.com/enjoy-digital/litex.git
PYTHON_LITEX_LICENSE = MIT
PYTHON_LITEX_LICENSE_FILES = LICENSE
PYTHON_LITEX_INSTALL_STAGING = NO
PYTHON_LITEX_INSTALL_TARGET = YES
PYTHON_LITEX_SETUP_TYPE = setuptools


$(eval $(python-package))
$(eval $(host-python-package))
