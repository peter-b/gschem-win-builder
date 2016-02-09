# -*-Makefile-*-

libtool_VERSION = 2.4.6
libtool_SOURCE_TARBALL = libtool-$(libtool_VERSION).tar.gz
libtool_SOURCE_URL = $(core_gnu_mirror_url)/libtool/$(libtool_SOURCE_TARBALL)
libtool_SOURCE = $(core_sources_dir)/$(libtool_SOURCE_TARBALL)

libtool_BUILD_DIR = $(core_build_dir)/libtool

libtool_STAMP = $(libtool_BUILD_DIR)/stamp.makepack

libtool_CONFIGURE_FLAGS = --enable-shared --disable-static

libtool: libtool_install

libtool_install: $(libtool_STAMP)
	set -e; \
	$(MAKE) -C $(libtool_BUILD_DIR)/libtool-$(libtool_VERSION) install

$(libtool_STAMP): Makefile libtool.mk $(libtool_SOURCE)
	set -e; \
	$(MAKE) libtool_clean; \
	mkdir -p $(libtool_BUILD_DIR); \
	cd $(libtool_BUILD_DIR); \
	tar xf $(libtool_SOURCE); \
	cd libtool-$(libtool_VERSION); \
	./configure $(core_configure_options); \
	$(MAKE); \
	touch $@

$(libtool_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(libtool_SOURCE_URL)

libtool_clean:
	rm -rf $(libtool_BUILD_DIR)
