# -*-Makefile-*-

atk_VERSION_MAJOR = 2.18
atk_VERSION_MINOR = 0
atk_VERSION = $(atk_VERSION_MAJOR).$(atk_VERSION_MINOR)
atk_SOURCE_TARBALL = atk-$(atk_VERSION).tar.xz
atk_SOURCE_URL = http://ftp.gnome.org/pub/gnome/sources/atk/$(atk_VERSION_MAJOR)/$(atk_SOURCE_TARBALL)
atk_SOURCE = $(core_sources_dir)/$(atk_SOURCE_TARBALL)

atk_BUILD_DIR = $(core_build_dir)/atk

atk_STAMP = $(atk_BUILD_DIR)/stamp.makepack

atk_CONFIGURE_FLAGS = --enable-static=no --enable-shared=yes

atk_DEPS = glib

atk: $(atk_DEPS)

atk: $(atk_STAMP)

$(atk_STAMP): Makefile atk.mk $(atk_SOURCE) | $(atk_DEPS)
	set -e; \
	$(MAKE) atk_clean; \
	mkdir -p $(atk_BUILD_DIR); \
	cd $(atk_BUILD_DIR); \
	tar xf $(atk_SOURCE); \
	cd atk-$(atk_VERSION); \
	./configure $(core_configure_options) $(atk_CONFIGURE_FLAGS); \
	$(MAKE) && $(MAKE) install; \
	touch $@

$(atk_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(atk_SOURCE_URL)

atk_clean:
	rm -rf $(atk_BUILD_DIR)

.PHONY: atk atk_install
