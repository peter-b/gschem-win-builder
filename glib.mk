# -*-Makefile-*-

glib_VERSION_MAJOR = 2.46
glib_VERSION_MINOR = 2
glib_VERSION = $(glib_VERSION_MAJOR).$(glib_VERSION_MINOR)
glib_SOURCE_TARBALL = glib-$(glib_VERSION).tar.xz
glib_SOURCE_URL = http://ftp.gnome.org/pub/gnome/sources/glib/$(glib_VERSION_MAJOR)/$(glib_SOURCE_TARBALL)
glib_SOURCE = $(core_sources_dir)/$(glib_SOURCE_TARBALL)

glib_BUILD_DIR = $(core_build_dir)/glib

glib_STAMP = $(glib_BUILD_DIR)/stamp.makepack

glib_CONFIGURE_FLAGS = --enable-static=no --enable-shared=yes

glib: zlib libffi gettext

glib: $(glib_STAMP)

$(glib_STAMP): Makefile glib.mk $(glib_SOURCE)
	set -e; \
	$(MAKE) glib_clean; \
	mkdir -p $(glib_BUILD_DIR); \
	cd $(glib_BUILD_DIR); \
	tar xf $(glib_SOURCE); \
	cd glib-$(glib_VERSION); \
	./configure $(core_configure_options) $(glib_CONFIGURE_FLAGS); \
	$(MAKE) && $(MAKE) install; \
	touch $@

$(glib_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(glib_SOURCE_URL)

glib_clean:
	rm -rf $(glib_BUILD_DIR)

.PHONY: glib glib_install
