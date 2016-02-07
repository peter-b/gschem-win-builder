# -*-Makefile-*-

gmp_VERSION = 6.1.0
gmp_SOURCE_TARBALL = gmp-$(gmp_VERSION).tar.lz
gmp_SOURCE_URL = $(core_gnu_mirror_url)/gmp/$(gmp_SOURCE_TARBALL)
gmp_SOURCE = $(core_sources_dir)/$(gmp_SOURCE_TARBALL)

gmp_BUILD_DIR = $(core_build_dir)/gmp

gmp_STAMP = $(gmp_BUILD_DIR)/stamp.makepack

gmp_CONFIGURE_FLAGS = --disable-shared --enable-static

gmp: libiconv

gmp: gmp_install

gmp_install: $(gmp_STAMP)
	set -e; \
	$(MAKE) -C $(gmp_BUILD_DIR)/gmp-$(gmp_VERSION) install

$(gmp_STAMP): Makefile gmp.mk $(gmp_SOURCE)
	set -e; \
	$(MAKE) gmp_clean; \
	mkdir -p $(gmp_BUILD_DIR); \
	cd $(gmp_BUILD_DIR); \
	tar xf $(gmp_SOURCE); \
	cd gmp-$(gmp_VERSION); \
	./configure $(core_configure_options) $(gmp_CONFIGURE_FLAGS); \
	$(MAKE); \
	touch $@

$(gmp_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(gmp_SOURCE_URL)

gmp_clean:
	rm -rf $(gmp_BUILD_DIR)

.PHONY: gmp gmp_install
