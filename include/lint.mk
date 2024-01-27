.PHONY: perllint perlcritic lint

perllint:
	-$(NOECHO) $(PERLRUN) -MO=Lint -cw finddup 2>&1 | grep -v "syntax OK" | grep -v "Can't locate"

perlcritic:
	-$(NOECHO) $(INSTALLSITEBIN)/perlcritic .

lint: perllint perlcritic

