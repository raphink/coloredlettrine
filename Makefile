CTANUPLOAD=ctanupload

CONTRIBUTION  = coloredlettrine
VERSION       = v0.1
SUMMARY       = Typeset colored initials
NAME          = Raphaël Pinson
EMAIL         = raphink@gmail.com
DIRECTORY     = /macros/latex/contrib/$(CONTRIBUTION)
DONOTANNOUNCE = 0
LICENSE       = free
FREEVERSION   = lppl
FILE          = $(CONTRIBUTION).tar.gz

SOURCEFILES   = $(CONTRIBUTION).dtx $(CONTRIBUTION).ins coloredlettrine-example.tex
PKGFILES      = $(CONTRIBUTION).sty
DOCFILES      = $(CONTRIBUTION).pdf coloredlettrine-example.pdf

export CONTRIBUTION VERSION NAME EMAIL SUMMARY DIRECTORY DONOTANNOUNCE ANNOUNCE NOTES LICENSE FREEVERSION FILE

# default rule
ctanify: $(FILE)

$(FILE): README $(SOURCEFILES) $(DOCFILES) $(PKGFILES)
	ctanify --pkgname $(CONTRIBUTION) $^

%.sty: %.dtx %.ins
	latex $*.ins

$(CONTRIBUTION).pdf: $(CONTRIBUTION).sty
	xelatex -interaction=batchmode $(CONTRIBUTION).dtx
	xelatex -interaction=batchmode $(CONTRIBUTION).dtx
	#lualatex -interaction=batchmode $(CONTRIBUTION).dtx
	#lualatex -interaction=batchmode $(CONTRIBUTION).dtx

%.pdf: %.tex
	xelatex -interaction=batchmode $<
	xelatex -interaction=batchmode $<
	#lualatex -interaction=batchmode $<
	#lualatex -interaction=batchmode $<

upload: ctanify
	$(CTANUPLOAD) -p

clean:
	rm -f *.aux *.glo *.idx *.log
	rm -f $(DOCFILES) $(PKGFILES)
	rm -f $(FILE)

