pure_site_install ::
	$(NOECHO) ln -sf finddup $(DESTINSTALLSITEBIN)/findlink

doc_site_install ::
	$(NOECHO) ln -sf finddup.1 $(DESTINSTALLSITEMAN1DIR)/findlink.1

uninstall_from_sitedirs ::
	$(NOECHO) rm -f $(DESTINSTALLSITEBIN)/findlink $(DESTINSTALLSITEMAN1DIR)/findlink.1

