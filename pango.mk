# -*-Makefile-*-

pango_VERSION_MAJOR = 1.38
pango_VERSION_MINOR = 1
pango_VERSION = $(pango_VERSION_MAJOR).$(pango_VERSION_MINOR)
pango_SOURCE_TARBALL = pango-$(pango_VERSION).tar.xz
pango_SOURCE_URL = http://ftp.gnome.org/pub/gnome/sources/pango/$(pango_VERSION_MAJOR)/$(pango_SOURCE_TARBALL)
pango_SOURCE = $(core_sources_dir)/$(pango_SOURCE_TARBALL)

pango_BUILD_DIR = $(core_build_dir)/pango

pango_STAMP = $(pango_BUILD_DIR)/stamp.makepack

pango_CONFIGURE_FLAGS = --enable-static=no --enable-shared=yes

pango_DEPS = glib cairo

pango: $(pango_DEPS)

pango: $(pango_STAMP)

$(pango_STAMP): Makefile pango.mk $(pango_SOURCE) | $(pango_DEPS)
	set -e; \
	$(MAKE) pango_clean; \
	mkdir -p $(pango_BUILD_DIR); \
	cd $(pango_BUILD_DIR); \
	tar xf $(pango_SOURCE); \
	cd pango-$(pango_VERSION); \
	./configure $(core_configure_options) $(pango_CONFIGURE_FLAGS); \
	$(MAKE) && $(MAKE) install; \
	touch $@

$(pango_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(pango_SOURCE_URL)

pango_clean:
	rm -rf $(pango_BUILD_DIR)

.PHONY: pango pango_install
