# -*-Makefile-*-

freetype_VERSION = 2.4.4
freetype_SOURCE_TARBALL = freetype-$(freetype_VERSION).tar.gz
freetype_SOURCE_URL = http://downloads.sourceforge.net/sourceforge/freetype/$(freetype_SOURCE_TARBALL)
freetype_SOURCE = $(core_sources_dir)/$(freetype_SOURCE_TARBALL)

freetype_BUILD_DIR = $(core_build_dir)/freetype

freetype_STAMP = $(freetype_BUILD_DIR)/stamp.makepack

freetype_CONFIGURE_FLAGS = --enable-shared

freetype: libpng

freetype: $(freetype_STAMP)

$(freetype_STAMP): Makefile freetype.mk $(freetype_SOURCE)
	set -e; \
	$(MAKE) freetype_clean; \
	mkdir -p $(freetype_BUILD_DIR); \
	cd $(freetype_BUILD_DIR); \
	tar xf $(freetype_SOURCE); \
	cd freetype-$(freetype_VERSION); \
	./configure $(core_configure_options) $(freetype_CONFIGURE_FLAGS); \
	$(MAKE) && $(MAKE) install; \
	touch $@

$(freetype_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(freetype_SOURCE_URL)

freetype_clean:
	rm -rf $(freetype_BUILD_DIR)

.PHONY: freetype freetype_install
