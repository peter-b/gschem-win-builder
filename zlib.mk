zlib_VERSION = 1.2.3

zlib_SOURCE_TARBALL = zlib-$(zlib_VERSION).tar.gz
zlib_SOURCE_URL = http://downloads.sourceforge.net/sourceforge/libpng/$(zlib_SOURCE_TARBALL)
zlib_SOURCE = $(core_sources_dir)/$(zlib_SOURCE_TARBALL)

zlib_PATCH_DIR = $(core_patches_dir)/zlib

zlib_BUILD_DIR = $(core_build_dir)/zlib/zlib-$(zlib_VERSION)

zlib_STAMP = $(core_build_dir)/zlib/stamp.makepack


zlib: $(zlib_STAMP)

$(zlib_STAMP): Makefile zlib.mk $(zlib_SOURCE)
	set -e; \
	rm -rf $(zlib_BUILD_DIR); \
	mkdir -p $(core_build_dir)/zlib; \
	cd $(core_build_dir)/zlib; \
	tar xf $(zlib_SOURCE); \
	cd $(zlib_BUILD_DIR); \
	for p in $(zlib_PATCH_DIR)/*.patch ; do \
	  patch -p1 < $$p; \
	done; \
	./configure --host="$(HOST)" --prefix="$(core_install_dir)" ; \
	$(MAKE) \
	  CFLAGS="$(CFLAGS)" CC=$(HOST)-gcc \
	  AR="$(HOST)-ar rcs" RANLIB="$(HOST)-ranlib" install
	touch $@

$(zlib_SOURCE):
	cd $(core_sources_dir) && \
	wget $(zlib_SOURCE_URL)
