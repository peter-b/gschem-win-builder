# -*-Makefile-*-

################################################################
# Configurable things
################################################################
BUILD ?= x86_64-pc-linux-gnu
BUILD_CPPFLAGS ?=
BUILD_LDFLAGS ?=
BUILD_CFLAGS ?=
BUILD_CXXFLAGS ?=

HOST ?= i686-w64-mingw32
CPPFLAGS ?=
LDFLAGS ?=
CFLAGS ?= -O3 -s -mms-bitfields -march=i686
CXXFLAGS ?=

################################################################
# Core variables etc
################################################################
core_top_dir = $(PWD)
core_sources_dir = $(core_top_dir)/sources
core_patches_dir = $(core_top_dir)/patches
core_build_dir = $(core_top_dir)/build-$(HOST)
core_install_dir = $(core_top_dir)/prefix-$(HOST)
core_build_install_dir = $(core_top_dir)/prefix-$(BUILD)
core_gnu_mirror_url = http://ftp.gnu.org/pub/gnu

core_configure_options = \
	--build="$(BUILD)" --host="$(HOST)" --prefix="$(core_install_dir)" \
	CPPFLAGS="$(CPPFLAGS) -I$(core_install_dir)/include" \
	LDFLAGS="$(LDFLAGS) -L$(core_install_dir)/lib" \
	CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)"

core_deps = Makefile $(core_sources_dir)

$(core_sources_dir):
	if test ! -d $@; then \
	  mkdir -p $@; \
	fi

export LD_LIBRARY_PATH:=$(core_build_install_dir)/lib:$(LD_LIBRARY_PATH)
export PATH:=$(core_build_install_dir)/bin:$(PATH)
export PKG_CONFIG_PATH:=$(core_install_dir)/lib/pkgconfig

MAKE_BUILD = $(MAKE) HOST=$(BUILD) CPPFLAGS=$(BUILD_CPPFLAGS) \
	CFLAGS=$(BUILD_CFLAGS) CXXFLAGS=$(BUILD_CXXFLAGS) \
	LDFLAGS=$(BUILD_LDFLAGS)

################################################################
# Recipes
################################################################

include guile.mk
include gmp.mk
include libunistring.mk
include libffi.mk
include gc.mk
include gettext.mk
include libiconv.mk
include libtool.mk
