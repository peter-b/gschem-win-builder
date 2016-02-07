# -*-Makefile-*-

libunistring_VERSION = 0.9.5
libunistring_SOURCE_TARBALL = libunistring-$(libunistring_VERSION).tar.gz
libunistring_SOURCE_URL = $(core_gnu_mirror_url)/libunistring/$(libunistring_SOURCE_TARBALL)
libunistring_SOURCE = $(core_sources_dir)/$(libunistring_SOURCE_TARBALL)

libunistring_BUILD_DIR = $(core_build_dir)/libunistring

libunistring_STAMP = $(libunistring_BUILD_DIR)/stamp.makepack

libunistring_CONFIGURE_FLAGS = --enable-threads=win32 --disable-shared --enable-static

libunistring: libiconv libtool

libunistring: libunistring_install

libunistring_install: $(libunistring_STAMP)
	set -e; \
	$(MAKE) -C $(libunistring_BUILD_DIR)/libunistring-$(libunistring_VERSION) install

$(libunistring_STAMP): Makefile libunistring.mk $(libunistring_SOURCE)
	set -e; \
	$(MAKE) libunistring_clean; \
	mkdir -p $(libunistring_BUILD_DIR); \
	cd $(libunistring_BUILD_DIR); \
	tar xf $(libunistring_SOURCE); \
	cd libunistring-$(libunistring_VERSION); \
	./configure $(core_configure_options) $(libunistring_CONFIGURE_FLAGS); \
	$(MAKE); \
	touch $@

$(libunistring_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(libunistring_SOURCE_URL)

libunistring_clean:
	rm -rf $(libunistring_BUILD_DIR)

.PHONY: libunistring libunistring_install
