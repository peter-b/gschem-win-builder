# -*-Makefile-*-

libffi_VERSION = 3.2.1
libffi_SOURCE_TARBALL = libffi-$(libffi_VERSION).tar.gz
libffi_SOURCE_URL = ftp://sourceware.org/pub/libffi/$(libffi_SOURCE_TARBALL)
libffi_SOURCE = $(core_sources_dir)/$(libffi_SOURCE_TARBALL)

libffi_BUILD_DIR = $(core_build_dir)/libffi

libffi_STAMP = $(libffi_BUILD_DIR)/stamp.makepack

libffi_CONFIGURE_FLAGS = --disable-shared --enable-static

libffi: libtool

ifeq ($(HOST),$(BUILD))
libffi:
else
libffi: libffi_install
endif

libffi_install: $(libffi_STAMP)
	set -e; \
	$(MAKE) -C $(libffi_BUILD_DIR)/libffi-$(libffi_VERSION) install

$(libffi_STAMP): Makefile libffi.mk $(libffi_SOURCE)
	set -e; \
	$(MAKE) libffi_clean; \
	mkdir -p $(libffi_BUILD_DIR); \
	cd $(libffi_BUILD_DIR); \
	tar xf $(libffi_SOURCE); \
	cd libffi-$(libffi_VERSION); \
	./configure $(core_configure_options) $(libffi_CONFIGURE_FLAGS); \
	$(MAKE); \
	touch $@

$(libffi_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(libffi_SOURCE_URL)

libffi_clean:
	rm -rf $(libffi_BUILD_DIR)

.PHONY: libffi libffi_install
