.PHONY: perllint perlcritic lint

PERLCRITIC = $(INSTALLSITEBIN)/perlcritic

perllint:
	-$(NOECHO) $(PERLRUN) -MO=Lint -cw finddup 2>&1 | grep -v "syntax OK" | grep -v "Can't locate"

perlcritic:
	-$(NOECHO) $(PERLCRITIC) .

lint: perllint perlcritic

