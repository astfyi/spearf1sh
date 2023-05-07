################################################################################
#
# python-migen
#
################################################################################

PYTHON_MIGEN_VERSION = 0.9.2
PYTHON_MIGEN_SITE_METHOD = git
PYTHON_MIGEN_SITE = git@github.com:m-labs/migen.git
PYTHON_MIGEN_LICENSE = MIT
PYTHON_MIGEN_LICENSE_FILES = LICENSE
PYTHON_MIGEN_INSTALL_STAGING = NO
PYTHON_MIGEN_INSTALL_TARGET = YES
PYTHON_MIGEN_SETUP_TYPE = setuptools


$(eval $(python-package))
$(eval $(host-python-package))
