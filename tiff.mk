# -*-Makefile-*-

tiff_VERSION = 4.0.6
tiff_SOURCE_TARBALL = tiff-$(tiff_VERSION).tar.gz
tiff_SOURCE_URL = ftp://ftp.remotesensing.org/pub/libtiff/$(tiff_SOURCE_TARBALL)
tiff_SOURCE = $(core_sources_dir)/$(tiff_SOURCE_TARBALL)

tiff_BUILD_DIR = $(core_build_dir)/tiff

tiff_STAMP = $(tiff_BUILD_DIR)/stamp.makepack

tiff_CONFIGURE_FLAGS = --enable-shared --disable-static

tiff: $(tiff_STAMP)

$(tiff_STAMP): Makefile tiff.mk $(tiff_SOURCE)
	set -e; \
	$(MAKE) tiff_clean; \
	mkdir -p $(tiff_BUILD_DIR); \
	cd $(tiff_BUILD_DIR); \
	tar xf $(tiff_SOURCE); \
	cd tiff-$(tiff_VERSION); \
	./configure $(core_configure_options) $(tiff_CONFIGURE_FLAGS); \
	$(MAKE) && $(MAKE) install; \
	touch $@

$(tiff_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(tiff_SOURCE_URL)

tiff_clean:
	rm -rf $(tiff_BUILD_DIR)
