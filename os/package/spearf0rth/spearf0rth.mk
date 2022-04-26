################################################################################
#
# spearf0rth
#
################################################################################

SPEARF0RTH_VERSION = v0.2.1
SPEARF0RTH_SITE_METHOD = git
SPEARF0RTH_SITE = git://github.com/cryptotronix/spearf0rth.git
SPEARF0RTH_SUBDIR = spearf0rth
SPEARF0RTH_LICENSE = MIT-like
SPEARF0RTH_LICENSE_FILES = LICENSE
SPEARF0RTH_INSTALL_STAGING = NO
SPEARF0RTH_INSTALL_TARGET = YES

$(eval $(cmake-package))
