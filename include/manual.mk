Manual.md: finddup
	$(NOECHO) $(PERLRUN) -MPod::Markdown -e 'Pod::Markdown->new->filter(@ARGV)' $< | \
		$(PERLRUN) -p0e 's/<!--.*?-->\n?//gs; s/--/-\\-/g' > $@
