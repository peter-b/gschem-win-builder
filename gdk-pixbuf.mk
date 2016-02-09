# -*-Makefile-*-

gdk_pixbuf_VERSION_MAJOR = 2.32
gdk_pixbuf_VERSION_MINOR = 3
gdk_pixbuf_VERSION = $(gdk_pixbuf_VERSION_MAJOR).$(gdk_pixbuf_VERSION_MINOR)
gdk_pixbuf_SOURCE_TARBALL = gdk-pixbuf-$(gdk_pixbuf_VERSION).tar.xz
gdk_pixbuf_SOURCE_URL = http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/$(gdk_pixbuf_VERSION_MAJOR)/$(gdk_pixbuf_SOURCE_TARBALL)
gdk_pixbuf_SOURCE = $(core_sources_dir)/$(gdk_pixbuf_SOURCE_TARBALL)

gdk_pixbuf_BUILD_DIR = $(core_build_dir)/gdk-pixbuf

gdk_pixbuf_STAMP = $(gdk_pixbuf_BUILD_DIR)/stamp.makepack

gdk_pixbuf_CONFIGURE_FLAGS = --enable-static=no --enable-shared=yes

gdk_pixbuf_DEPS = glib libpng tiff jpeg

gdk-pixbuf: $(gdk_pixbuf_STAMP) $(gdk_pixbuf_DEPS)

$(gdk_pixbuf_STAMP): Makefile gdk-pixbuf.mk $(gdk_pixbuf_SOURCE) | $(gdk_pixbuf_DEPS)
	set -e; \
	$(MAKE) gdk_pixbuf_clean; \
	mkdir -p $(gdk_pixbuf_BUILD_DIR); \
	cd $(gdk_pixbuf_BUILD_DIR); \
	tar xf $(gdk_pixbuf_SOURCE); \
	cd gdk-pixbuf-$(gdk_pixbuf_VERSION); \
	./configure $(core_configure_options) $(gdk_pixbuf_CONFIGURE_FLAGS); \
	$(MAKE) && $(MAKE) install; \
	touch $@

$(gdk_pixbuf_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(gdk_pixbuf_SOURCE_URL)

gdk_pixbuf_clean:
	rm -rf $(gdk_pixbuf_BUILD_DIR)

.PHONY: gdk_pixbuf gdk_pixbuf_install
