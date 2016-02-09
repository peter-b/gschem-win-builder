# -*-Makefile-*-

libiconv_VERSION = 1.14
libiconv_SOURCE_TARBALL = libiconv-$(libiconv_VERSION).tar.gz
libiconv_SOURCE_URL = $(core_gnu_mirror_url)/libiconv/$(libiconv_SOURCE_TARBALL)
libiconv_SOURCE = $(core_sources_dir)/$(libiconv_SOURCE_TARBALL)

libiconv_BUILD_DIR = $(core_build_dir)/libiconv

libiconv_STAMP = $(libiconv_BUILD_DIR)/stamp.makepack

libiconv_CONFIGURE_FLAGS = --disable-static

libiconv: libtool

libiconv: $(libiconv_STAMP)

$(libiconv_STAMP): Makefile libiconv.mk $(libiconv_SOURCE)
	set -e; \
	$(MAKE) libiconv_clean; \
	mkdir -p $(libiconv_BUILD_DIR); \
	cd $(libiconv_BUILD_DIR); \
	tar xf $(libiconv_SOURCE); \
	cd libiconv-$(libiconv_VERSION); \
	./configure $(core_configure_options) $(libiconv_CONFIGURE_FLAGS); \
	$(MAKE) && $(MAKE) install; \
	touch $@

$(libiconv_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(libiconv_SOURCE_URL)

libiconv_clean:
	rm -rf $(libiconv_BUILD_DIR)

.PHONY: libiconv libiconv_install
