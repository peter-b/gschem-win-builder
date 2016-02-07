# -*-Makefile-*-

gc_VERSION_MAJOR = 7.2
gc_VERSION_POINT = e
gc_VERSION = $(gc_VERSION_MAJOR)$(gc_VERSION_POINT)

gc_SOURCE_TARBALL = gc-$(gc_VERSION).tar.gz
gc_SOURCE_URL = http://launchpad.net/libgc/main/$(gc_VERSION)/+download/$(gc_SOURCE_TARBALL)
gc_SOURCE = $(core_sources_dir)/$(gc_SOURCE_TARBALL)

gc_BUILD_DIR = $(core_build_dir)/gc/gc-$(gc_VERSION_MAJOR)

gc_INSTALL_LIB_DIR = $(core_install_dir)/lib
gc_INSTALL_INCLUDE_DIR = $(core_install_dir)/include
gc_INSTALL_HEADER_DIR = $(gc_INSTALL_INCLUDE_DIR)/gc

gc: gc_install

.PHONY: gc

# Rules for unpacking source
# ----------------------------------------------------------------

gc_SOURCE_STAMP = $(core_build_dir)/gc/gc-source.stamp

$(gc_SOURCE):
	cd $(core_sources_dir) && wget $(gc_SOURCE_URL)

$(gc_SOURCE_STAMP): Makefile gc.mk $(gc_SOURCE)
	rm -rf $(core_build_dir)/gc
	mkdir -p $(core_build_dir)/gc
	cd $(core_build_dir)/gc && \
	tar -xf $(gc_SOURCE)
	touch $@

gc_unpack: $(gc_SOURCE_STAMP)

.PHONY: gc_unpack

# Rules for libatomic_ops
# ----------------------------------------------------------------

gc_libatomicops_STAMP = $(core_build_dir)/gc/libatomicops-stamp.makepack
gc_libatomicops_INSTALL_STAMP = $(core_build_dir)/gc/libatomicops-stamp.makepack-install

$(gc_libatomicops_INSTALL_STAMP): $(gc_libatomicops_STAMP)
	$(MAKE) -C $(gc_BUILD_DIR)/libatomic_ops/ install
	touch $@

$(gc_libatomicops_STAMP): $(gc_SOURCE_STAMP)
	set -e; \
	cd $(gc_BUILD_DIR)/libatomic_ops/; \
	./configure $(core_configure_options)
	$(MAKE) -C $(gc_BUILD_DIR)/libatomic_ops/
	touch $@

# Rules for libgc
# ----------------------------------------------------------------

gc_STAMP = $(core_build_dir)/gc/gc-stamp.makepack

ifeq ($(HOST),$(BUILD))
gc_TOOL_PREFIX=
else
gc_TOOL_PREFIX=$(HOST)-
endif

# Manually install the libgc static library and header files into the
# installation prefix
gc_install: $(gc_STAMP)
	mkdir -p $(gc_INSTALL_LIB_DIR)
	cp $(gc_BUILD_DIR)/gc.a $(gc_INSTALL_LIB_DIR)/libgc.a
	if test -d $(gc_INSTALL_HEADER_DIR); then \
	  rm -rf $(gc_INSTALL_HEADER_DIR); \
	fi
	mkdir -p $(gc_INSTALL_INCLUDE_DIR)
	cp -r $(gc_BUILD_DIR)/include $(gc_INSTALL_HEADER_DIR)

# gc's build rules call the machine that's being used to compile it
# the host, and makepack calls the machine that's the program's being
# compiled to run *on* the host. Confusing!

# ) -O2 -I./include -DATOMIC_UNCOLLECTABLE -DNO_EXECUTE_PERMISSION -DALL_INTERIOR_POINTERS" \
#	HOSTCFLAGS=" -O2 -I./include -I$(core_build_install_dir)/include -DATOMIC_UNCOLLECTABLE -DNO_EXECUTE_PERMISSION -DALL_INTERIOR_POINTERS" \

$(gc_STAMP): $(gc_libatomicops_INSTALL_STAMP)
	cd $(gc_BUILD_DIR) && \
	$(MAKE) -f Makefile.direct \
	CC="$(gc_TOOL_PREFIX)gcc" \
	CXX="$(gc_TOOL_PREFIX)g++" \
	AS="$(gc_TOOL_PREFIX)as" \
	AR="$(gc_TOOL_PREFIX)ar" \
	RANLIB="$(gc_TOOL_PREFIX)ranlib" \
	CFLAGS="$(CFLAGS) -I./include" \
	HOSTCC="cc" \
	HOSTCFLAGS="$(BUILD_CFLAGS) -I./include" \
	AO_INSTALL_DIR="$(core_install_dir)" \
	gc.a
	touch $@

.PHONY: gc_install


.PHONY: gc_libatomicops_install
