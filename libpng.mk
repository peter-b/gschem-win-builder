libpng_VERSION = 1.5.26

libpng_SOURCE_TARBALL = libpng-$(libpng_VERSION).tar.xz
libpng_SOURCE_URL = http://downloads.sourceforge.net/sourceforge/libpng/$(libpng_SOURCE_TARBALL)
libpng_SOURCE = $(core_sources_dir)/$(libpng_SOURCE_TARBALL)

libpng_BUILD_DIR = $(core_build_dir)/libpng/libpng-$(libpng_VERSION)

libpng_STAMP = $(core_build_dir)/libpng/stamp.makepack

libpng: zlib
libpng: $(libpng_STAMP)

$(libpng_STAMP): Makefile libpng.mk $(libpng_SOURCE)
	set -e; \
	rm -rf $(libpng_BUILD_DIR); \
	mkdir -p $(core_build_dir)/libpng; \
	cd $(core_build_dir)/libpng; \
	tar xf $(libpng_SOURCE); \
	cd $(libpng_BUILD_DIR); \
	./configure $(core_configure_options) \
	  --enable-shared --disable-static ; \
	$(MAKE) install
	touch $@

$(libpng_SOURCE):
	cd $(core_sources_dir) && \
	wget $(libpng_SOURCE_URL)
