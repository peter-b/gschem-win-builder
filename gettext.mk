# -*-Makefile-*-

gettext_VERSION = 0.19.3
gettext_SOURCE_TARBALL = gettext-$(gettext_VERSION).tar.gz
gettext_SOURCE_URL = $(core_gnu_mirror_url)/gettext/$(gettext_SOURCE_TARBALL)
gettext_SOURCE = $(core_sources_dir)/$(gettext_SOURCE_TARBALL)

gettext_BUILD_DIR = $(core_build_dir)/gettext

gettext_STAMP = $(gettext_BUILD_DIR)/stamp.makepack

gettext_CONFIGURE_FLAGS = \
	--prefix="$(core_install_dir)" \
	--enable-relocatable --enable-shared --disable-static \
	--host="$(HOST)" --build="$(BUILD)" CFLAGS="$(CFLAGS) -O2"

gettext: libiconv

gettext: $(gettext_STAMP)

$(gettext_STAMP): Makefile gettext.mk $(gettext_SOURCE)
	set -e; \
	$(MAKE) gettext_clean; \
	mkdir -p $(gettext_BUILD_DIR); \
	cd $(gettext_BUILD_DIR); \
	tar xf $(gettext_SOURCE); \
	cd gettext-$(gettext_VERSION); \
	./configure $(gettext_CONFIGURE_FLAGS); \
	$(MAKE) && $(MAKE) install; \
	touch $@

$(gettext_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(gettext_SOURCE_URL)

gettext_clean:
	rm -rf $(gettext_BUILD_DIR)

.PHONY: gettext gettext_install
