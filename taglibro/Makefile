.PHONY: all index git

all:
	cat Makefile

index:
	bash script/index.sh > index.html

%.html: %.md
	mdc $^ | \
		pandoc -s -t html5 \
		-B templates/post.header.html \
		-A ../resources/js/toc.html \
		-A templates/post.footer.html \
		-A ../resources/js/toc.html \
		--mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML \
		--css ../../../resources/css/c.css \
		--css https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css \
		-o $@

edit:
	bash script/edit.sh

today:
	bash script/edit.sh --query today

git: index
	git add .
	git commit -a -m "taglibro/ `LANG=en date`"
	git push
