.PHONY: all index git

all:
	cat Makefile

index:
	sh script/index.sh > index.html

%.html: %.md
	mdc $^ | \
	pandoc -t html5 \
		--mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML \
		-B templates/post.header.html \
		-A templates/index.footer.html \
		--css=../../../resources/css/c.css --css=../../css/post.css -o $@

edit:
	bash script/edit.sh

git:
	git add --all
	git commit -a -m "taglibro/ `LANG=en date`"
	git push
