# -*-Makefile-*-

gettext_VERSION = 0.19.3
gettext_SOURCE_TARBALL = gettext-$(gettext_VERSION).tar.gz
gettext_SOURCE_URL = $(core_gnu_mirror_url)/gettext/$(gettext_SOURCE_TARBALL)
gettext_SOURCE = $(core_sources_dir)/$(gettext_SOURCE_TARBALL)

gettext_BUILD_DIR = $(core_build_dir)/gettext

gettext_STAMP = $(gettext_BUILD_DIR)/stamp.makepack

gettext_CONFIGURE_FLAGS = --enable-relocatable --disable-shared --enable-static

gettext: libiconv

ifeq ($(HOST),$(BUILD))
gettext:
else
gettext: gettext_install
endif

gettext_install: $(gettext_STAMP)
	set -e; \
	$(MAKE) -C $(gettext_BUILD_DIR)/gettext-$(gettext_VERSION) install

$(gettext_STAMP): Makefile gettext.mk $(gettext_SOURCE)
	set -e; \
	$(MAKE) gettext_clean; \
	mkdir -p $(gettext_BUILD_DIR); \
	cd $(gettext_BUILD_DIR); \
	tar xf $(gettext_SOURCE); \
	cd gettext-$(gettext_VERSION); \
	./configure $(core_configure_options) $(gettext_CONFIGURE_FLAGS); \
	$(MAKE); \
	touch $@

$(gettext_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(gettext_SOURCE_URL)

gettext_clean:
	rm -rf $(gettext_BUILD_DIR)

.PHONY: gettext gettext_install
