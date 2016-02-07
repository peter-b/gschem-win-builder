guile_VERSION = 2.0.11
guile_SOURCE_TARBALL = guile-$(guile_VERSION).tar.gz
guile_SOURCE_URL = $(core_gnu_mirror_url)/guile/$(guile_SOURCE_TARBALL)
guile_SOURCE = $(core_sources_dir)/$(guile_SOURCE_TARBALL)

guile_BUILD_DIR = $(core_build_dir)/guile/guile-$(guile_VERSION)

guile_STAMP = $(core_build_dir)/guile/stamp.makepack
guile_INSTALL_STAMP = $(core_build_dir)/guile/stamp.makepack-install

guile_CONFIGURE_FLAGS = \
	--disable-shared --enable-static --disable-rpath \
	--enable-debug-malloc --enable-guile-debug \
	--disable-deprecated --with-sysroot=$(core_install_dir) \
	--with-libunistring-prefix="$(core_install_dir)" \
	--with-libiconv-prefix="$(core_install_dir)" \
	--with-libltdl-prefix="$(core_install_dir)" \
	--with-libgmp-prefix="$(core_install_dir)" \
	--without-threads \
	BDW_GC_CFLAGS="-I$(core_install_dir)/include" \
	BDW_GC_LIBS="-L$(core_install_dir)/lib -lgc" \
	CC_FOR_BUILD=cc

guile_GUILE_EXE = $(core_install_dir)/bin/guile

# Rules for recursively building the version of Guile used while
# compiling Guile
# ----------------------------------------------------------------

ifeq ($(BUILD),$(HOST))
else
guile_CONFIGURE_FLAGS += GUILE_FOR_BUILD="$(guile_GUILE_EXE_FOR_BUILD)"

guile_GUILE_EXE_FOR_BUILD = $(core_build_install_dir)/bin/guile

$(guile_GUILE_EXE_FOR_BUILD): guile.mk $(guile_SOURCE) $(core_setup)
	$(MAKE_BUILD) $@
endif

# Rules for building the HOST guile
# ----------------------------------------------------------------

guile: $(guile_INSTALL_STAMP)

$(guile_GUILE_EXE): $(guile_INSTALL_STAMP)

$(guile_INSTALL_STAMP): $(guile_STAMP)
	$(MAKE) -C $(guile_BUILD_DIR) install
	touch $@

$(guile_STAMP): libtool gmp libunistring libffi gc gettext

$(guile_STAMP): Makefile guile.mk $(guile_SOURCE) $(guile_GUILE_EXE_FOR_BUILD)
	set -e; \
	$(MAKE) guile_clean; \
	mkdir -p $(core_build_dir)/guile; \
	cd $$_; \
	tar -xf $(guile_SOURCE); \
	cd $(guile_BUILD_DIR); \
	for p in $(core_patches_dir)/guile/* ; do \
	  patch -p1 < $$p; \
	done; \
	./configure $(core_configure_options) $(guile_CONFIGURE_FLAGS); \
	CPATH="$(core_install_dir)/include" $(MAKE); \
	touch $@

guile_clean:
	rm -rf $(core_build_dir)/guile

.PHONY: guile guile_install guile_clean

# ----------------------------------------------------------------

$(guile_SOURCE):
	cd $(core_sources_dir) && \
	wget $(guile_SOURCE_URL)
