# -*-Makefile-*-

jpeg_VERSION = 9a
jpeg_SOURCE_TARBALL = jpegsrc.v$(jpeg_VERSION).tar.gz
jpeg_SOURCE_URL = http://www.ijg.org/files/$(jpeg_SOURCE_TARBALL)
jpeg_SOURCE = $(core_sources_dir)/$(jpeg_SOURCE_TARBALL)

jpeg_BUILD_DIR = $(core_build_dir)/jpeg

jpeg_STAMP = $(jpeg_BUILD_DIR)/stamp.makepack

jpeg_CONFIGURE_FLAGS = --enable-shared --disable-static

jpeg: $(jpeg_STAMP)

$(jpeg_STAMP): Makefile jpeg.mk $(jpeg_SOURCE)
	set -e; \
	$(MAKE) jpeg_clean; \
	mkdir -p $(jpeg_BUILD_DIR); \
	cd $(jpeg_BUILD_DIR); \
	tar xf $(jpeg_SOURCE); \
	cd jpeg-$(jpeg_VERSION); \
	./configure $(core_configure_options) $(jpeg_CONFIGURE_FLAGS); \
	$(MAKE) && $(MAKE) install; \
	touch $@

$(jpeg_SOURCE):
	set -e; \
	cd $(core_sources_dir); \
	wget $(jpeg_SOURCE_URL)

jpeg_clean:
	rm -rf $(jpeg_BUILD_DIR)
