.PHONY: all index git

all:
	cat Makefile

index:
	bash script/index.sh > index.html

%.html: %.md
	$(eval DESCRIPTION := $(shell cat $^ | grep '^## ' | sed 's/^#* //g' | tr '\n' ' ' | sed 's/ *$$//g'))
	mdc $^ | \
		pandoc -s -t html5 \
		--template templates/post.body.html \
		-V "description=$(DESCRIPTION)" \
		-B templates/post.header.html \
		-A templates/post.footer.html \
		-A ../resources/js/toc.html \
		--mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML \
		--css ../../../resources/css/c.css \
		--css https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css \
		-o $@

edit:
	bash script/edit.sh

today:
	bash script/edit.sh --query today

new:
	bash script/edit.sh --query new

git: index
	git add .
	git commit -a -m "taglibro/ `LANG=en date`"
	git push
