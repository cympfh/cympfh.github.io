all: index others

others:
	for f in `\ls -1 *.md | grep -v README`; do make $${f%md}html; done

index: index.html
index.html: README.md
	pandoc -t html5 -s --css ../resources/css/c.css $^ -o $@

%.html: %.md
	mdc <$^ |\
		pandoc -s -t html5 \
		-A ../resources/js/toc.html \
		--mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML \
		--css ../resources/css/c.css \
		--css https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css \
		-o $@

git:
	git add --all
	git commit -a -m "memo/ `date`"
	git push
