# -*-Makefile-*-

gtk2_VERSION_MAJOR = 2.24
gtk2_VERSION_MINOR = 29
gtk2_VERSION = $(gtk2_VERSION_MAJOR).$(gtk2_VERSION_MINOR)
gtk2_SOURCE_TARBALL = gtk+-$(gtk2_VERSION).tar.xz
gtk2_SOURCE_URL = http://ftp.gnome.org/pub/gnome/sources/gtk+/$(gtk2_VERSION_MAJOR)/$(gtk2_SOURCE_TARBALL)
gtk2_SOURCE = $(core_sources_dir)/$(gtk2_SOURCE_TARBALL)

gtk2_BUILD_DIR = $(core_build_dir)/gtk+

gtk2_STAMP = $(gtk2_BUILD_DIR)/stamp.makepack

gtk2_CONFIGURE_FLAGS = --enable-static=no --enable-shared=yes \
	--disable-cups --with-included-immodules

gtk2_DEPS = atk cairo pango gdk-pixbuf

gtk2: $(gtk2_STAMP) $(gtk2_DEPS)

$(gtk2_STAMP): Makefile gtk2.mk $(gtk2_SOURCE) | $(gtk2_DEPS)
	set -e; \
	$(MAKE) gtk2_clean; \
	mkdir -p $(gtk2_BUILD_DIR); \
	cd $(gtk2_BUILD_DIR); \
	tar xf $(gtk2_SOURCE); \
	cd gtk+-$(gtk2_VERSION); \
	./configure $(core_configure_options) $(gtk2_CONFIGURE_FLAGS); \
	$(MAKE) && $(MAKE) install; \
	touch $@

$(gtk2_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(gtk2_SOURCE_URL)

gtk2_clean:
	rm -rf $(gtk2_BUILD_DIR)

.PHONY: gtk2 gtk2_install
