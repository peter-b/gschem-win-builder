# -*-Makefile-*-

hicolor_icon_theme_VERSION = 0.15
hicolor_icon_theme_SOURCE_TARBALL = hicolor-icon-theme-$(hicolor_icon_theme_VERSION).tar.xz
hicolor_icon_theme_SOURCE_URL = http://icon-theme.freedesktop.org/releases//$(hicolor_icon_theme_SOURCE_TARBALL)
hicolor_icon_theme_SOURCE = $(core_sources_dir)/$(hicolor_icon_theme_SOURCE_TARBALL)

hicolor_icon_theme_BUILD_DIR = $(core_build_dir)/hicolor-icon-theme

hicolor_icon_theme_STAMP = $(hicolor_icon_theme_BUILD_DIR)/stamp.makepack

hicolor_icon_theme_CONFIGURE_FLAGS = --enable-static=no --enable-shared=yes --disable-gtk

hicolor-icon-theme: $(hicolor_icon_theme_STAMP)

$(hicolor_icon_theme_STAMP): Makefile hicolor-icon-theme.mk $(hicolor_icon_theme_SOURCE)
	set -e; \
	$(MAKE) hicolor-icon-theme_clean; \
	mkdir -p $(hicolor_icon_theme_BUILD_DIR); \
	cd $(hicolor_icon_theme_BUILD_DIR); \
	tar xf $(hicolor_icon_theme_SOURCE); \
	cd hicolor-icon-theme-$(hicolor_icon_theme_VERSION); \
	./configure $(core_configure_options) $(hicolor_icon_theme_CONFIGURE_FLAGS); \
	$(MAKE) all && $(MAKE) install; \
	touch $@

$(hicolor_icon_theme_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(hicolor_icon_theme_SOURCE_URL)

hicolor-icon-theme_clean:
	rm -rf $(hicolor_icon_theme_BUILD_DIR)

.PHONY: hicolor-icon-theme hicolor-icon-theme_install
