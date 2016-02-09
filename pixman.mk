# -*-Makefile-*-

pixman_VERSION = 0.32.8
pixman_SOURCE_TARBALL = pixman-$(pixman_VERSION).tar.gz
pixman_SOURCE_URL = http://www.cairographics.org/releases//$(pixman_SOURCE_TARBALL)
pixman_SOURCE = $(core_sources_dir)/$(pixman_SOURCE_TARBALL)

pixman_BUILD_DIR = $(core_build_dir)/pixman

pixman_STAMP = $(pixman_BUILD_DIR)/stamp.makepack

pixman_CONFIGURE_FLAGS = --enable-static=no --enable-shared=yes --disable-gtk

pixman: glib libpng

pixman: $(pixman_STAMP)

$(pixman_STAMP): Makefile pixman.mk $(pixman_SOURCE)
	set -e; \
	$(MAKE) pixman_clean; \
	mkdir -p $(pixman_BUILD_DIR); \
	cd $(pixman_BUILD_DIR); \
	tar xf $(pixman_SOURCE); \
	cd pixman-$(pixman_VERSION); \
	./configure $(core_configure_options) $(pixman_CONFIGURE_FLAGS); \
	$(MAKE) all && $(MAKE) install; \
	touch $@

$(pixman_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(pixman_SOURCE_URL)

pixman_clean:
	rm -rf $(pixman_BUILD_DIR)

.PHONY: pixman pixman_install
