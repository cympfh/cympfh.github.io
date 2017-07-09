all: index.html posts

index: index.html

index.html: README.md
	cat resources/index.html.h > $@
	pandoc -i README.md | sed 's/a href/a target=fr href/g' >>$@

.PHONY: posts

posts:
	ls -1 *.md | grep -v README.md | sed 's/.*/make &/; s/.md$$/.html/g' | sh

%.html: %.md
	mdc <$^ \
		pandoc -s -t html5 \
		-B resources/header.html \
		-A ../resources/js/toc.html \
		--mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML \
		--css ../resources/css/c.css \
		--css ../resources/css/d.css \
		--css https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.cs \
		-o $@
