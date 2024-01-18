.PHONY: perlwarn perlcritic lint

PERLCRITIC = $(INSTALLSITEBIN)/perlcritic

perlwarn:
	-$(NOECHO) $(PERLRUN) -MO=Lint -cw finddup 2>&1 | grep -v "syntax OK" | grep -v "Can't locate"

perlcritic:
	-$(NOECHO) $(PERLCRITIC) .

lint: perlwarn perlcritic

