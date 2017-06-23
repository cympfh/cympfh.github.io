all: index.html others

others:
	for f in `\ls -1 *.md | grep -v README`; do make $${f%md}html; done

index.html: README.md
	pandoc -t html5 -s --css ../resources/css/c.css $^ -o $@

%.html: %.md
	pandoc -t html5 --mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML -s --css ../resources/css/c.css $^ -o $@

git:
	git add --all
	git commit -a -m "`date`"
	git push
