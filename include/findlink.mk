pure_site_install ::
	$(NOECHO) ln -s finddup $(DESTINSTALLSITEBIN)/findlink

doc_site_install ::
	$(NOECHO) ln -s finddup.1 $(DESTINSTALLSITEMAN1DIR)/findlink.1

uninstall_from_sitedirs ::
	$(NOECHO) rm -f $(DESTINSTALLSITEBIN)/findlink $(DESTINSTALLSITEMAN1DIR)/findlink.1

