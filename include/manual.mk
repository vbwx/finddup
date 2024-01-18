Manual.md: finddup
	$(NOECHO) $(PERLRUN) -MPod::Markdown -e 'Pod::Markdown->new->filter(@ARGV)' $< > $@
