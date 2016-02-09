# -*-Makefile-*-

cairo_VERSION = 1.15.2
cairo_SOURCE_TARBALL = cairo-$(cairo_VERSION).tar.xz
cairo_SOURCE_URL = http://www.cairographics.org/snapshots/$(cairo_SOURCE_TARBALL)
cairo_SOURCE = $(core_sources_dir)/$(cairo_SOURCE_TARBALL)

cairo_BUILD_DIR = $(core_build_dir)/cairo

cairo_STAMP = $(cairo_BUILD_DIR)/stamp.makepack

cairo_CONFIGURE_FLAGS = --enable-static=no --enable-shared=yes

ifeq ($(findstring mingw,$(HOST)),mingw)
cairo_CPPFLAGS = $(CPPFLAGS) \
	-I $(core_install_dir)/include \
	-D ffs=__builtin_ffs

cairo_CONFIGURE_FLAGS += --disable-xlib --disable-xlib-xrender \
	--disable-xcb --disable-fc CPPFLAGS="$(cairo_CPPFLAGS)"
endif

cairo_DEPS = libpng pixman freetype

cairo: $(cairo_DEPS)

cairo: $(cairo_STAMP)

$(cairo_STAMP): Makefile cairo.mk $(cairo_SOURCE) | $(cairo_DEPS)
	set -e; \
	$(MAKE) cairo_clean; \
	mkdir -p $(cairo_BUILD_DIR); \
	cd $(cairo_BUILD_DIR); \
	tar xf $(cairo_SOURCE); \
	cd cairo-$(cairo_VERSION); \
	./configure $(core_configure_options) $(cairo_CONFIGURE_FLAGS); \
	$(MAKE) && $(MAKE) install; \
	touch $@

$(cairo_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(cairo_SOURCE_URL)

cairo_clean:
	rm -rf $(cairo_BUILD_DIR)

.PHONY: cairo cairo_install
