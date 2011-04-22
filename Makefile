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

SITEHOME := ../contextlogger.github.com
PAGEDIR := fnmatch-python
DLDIR := $(PAGEDIR)/download
MKINDEX := ../tools/bin/make-index-page.rb

release :
	-mkdir -p $(SITEHOME)/$(DLDIR)
	cp fnmatch-pys60v1_self.sisx $(SITEHOME)/$(DLDIR)/
	$(MKINDEX) $(SITEHOME)/$(DLDIR)
	chmod -R a+rX $(SITEHOME)/$(PAGEDIR)
	cd $(SITEHOME) && git add $(PAGEDIR)

upload :
	cd $(SITEHOME) && git commit -a -m updates && git push

-include local.mk
