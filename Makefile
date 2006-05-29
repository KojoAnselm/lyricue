BINARIES = lyricue lyricue_remote lyricue_server import_media
SHARE = lyricue.glade images/lyricue.png images/lyricue-icon.png
SQL = mysql/MySQL_create_Table.sql mysql/MySQL_create_media.sql mysql/Update_1.2.sql mysql/Update_1.9.sql
DESKTOP = lyricue.desktop lyricue_server.desktop
ETC = default.conf access.conf
INSTALL = /usr/bin/install -c -m 755
INSTALLDATA = /usr/bin/install -c -m 644 -D
POFILES = po/de.po po/en_US.po po/fr.po po/nl.po
MOFILES = po/de.po.mo po/en_US.po.mo po/fr.po.mo po/nl.po.mo

all: $(MOFILES)

%.po.mo:
	@for t in $(POFILES); do msgfmt -o $$t.mo $$t;done

install: 
	mkdir -p $(DESTDIR)/usr/bin
	$(INSTALL) $(BINARIES) $(DESTDIR)/usr/bin

	mkdir -p $(DESTDIR)/usr/share/lyricue
	$(INSTALLDATA) $(SHARE) $(DESTDIR)/usr/share/lyricue

	mkdir -p $(DESTDIR)/usr/share/lyricue/mysql
	$(INSTALLDATA) $(SQL) $(DESTDIR)/usr/share/lyricue/mysql

	mkdir -p $(DESTDIR)/etc/lyricue
	$(INSTALLDATA) $(ETC) $(DESTDIR)/etc/lyricue

	mkdir -p $(DESTDIR)/usr/share/applications
	$(INSTALLDATA) $(DESKTOP) $(DESTDIR)/usr/share/applications

	@for t in $(MOFILES); do l=`basename $$t .po.mo`; $(INSTALLDATA) $$t $(DESTDIR)/usr/share/locale/$$l/LC_MESSAGES/lyricue.mo;done

uninstall:
	cd $(DESTDIR)/usr/bin; \
	rm $(BINARIES)
	cd $(DESTDIR)/usr/share/lyricue; \
	rm $(SHARE) $(SQL)
	cd $(DESTDIR)/usr/share/applications; \
	rm $(DESKTOP)

clean:
	rm $(MOFILES)