all:
	for f in `ls -1 *.md|grep -v README`; do make $${f%md}html; done
	make index.html

CSS := ../../../resources/css/c.css
LIB := ../../../resources/js/toc.html

index.html: README.md
	mdc <$^ | pandoc -t html5 --mathml -s --css ${CSS} -A ${LIB} -o $@

%.html: %.md
	mdc <$^ | pandoc -t html5 --mathml -s --css ${CSS} -A ${LIB} -o $@
