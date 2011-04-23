CERT := dev
KIT := s60_30
DEVICE := default

SIGN := ../tools/bin/do-sis-signing.rb 
SISX_FILE := fnmatch-pys60v1_$(CERT).sisx

all :
	$(MAKE) sis CERT=dev
	$(MAKE) sis CERT=self

sis :
	$(SIGN) -k $(KIT) --makesis --signsis -c $(CERT) -i pys60v1-fnmatch.pkg -o $(SISX_FILE)

.PHONY : web

web :
	cp -a ../tools/web/hiit.css web/
	../tools/bin/txt2tags --target xhtml --infile web/index.txt2tags.txt --outfile web/index.html --encoding utf-8 --verbose -C web/config.t2t

HTDOCS := ../contextlogger.github.com
PAGEPATH := fnmatch-python
PAGEHOME := $(HTDOCS)/$(PAGEPATH)
DLPATH := $(PAGEPATH)/download
DLHOME := $(HTDOCS)/$(DLPATH)
MKINDEX := ../tools/bin/make-index-page.rb

release :
	-mkdir -p $(DLHOME)
	cp -a fnmatch-pys60v1_self.sisx $(DLHOME)/
	$(MKINDEX) $(DLHOME)
	cp -a web/*.css $(PAGEHOME)/
	cp -a web/*.html $(PAGEHOME)/
	chmod -R a+rX $(PAGEHOME)

upload :
	cd $(HTDOCS) && git add $(PAGEPATH) && git commit -a -m updates && git push

-include local.mk
