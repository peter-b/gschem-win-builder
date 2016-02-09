gtk2: gtk2_install

gtk2_install: $(gtk2_STAMP)

$(gtk2_STAMP): hicolor-icon-theme atk cairo pango gdk-pixbuf
$(gtk2_STAMP): Makefile gtk+.mk
