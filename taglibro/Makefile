.PHONY: all index git rss

all:
	cat Makefile

index:
	bash script/index.sh > index.html

dev:
	bash script/hotcompile.sh

all-html:
	for f in 2*/*/*.md; do make $${f%md}html; done

%.html: %.md
	$(eval DESCRIPTION := $(shell cat $^ | grep '^## ' | sed 's/^#* //g' | sed ':a;N;$$!ba;s/\n/, /g'))
	cat $^ | \
		mdc | \
		pandoc -s -t html5 \
		--template resources/templates/post.body.html \
		-V "description=$(DESCRIPTION)" \
		-B resources/templates/post.header.html \
		-A resources/templates/post.footer.html \
		-A ../resources/js/toc.html \
		--mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML \
		--css ../../resources/css/c.css \
		--css ../../../resources/css/c.css \
		--css ../../../resources/css/youtube.css \
		--css ../../../resources/css/web_emb.css \
		--css https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css \
		-o $@

edit:
	bash script/edit.sh

today:
	bash script/edit.sh --query today

new:
	bash script/edit.sh --query new

rss:
	bash script/rss.sh > rss.xml

git: index rss
	git add .
	git commit -a -m "taglibro/ `LC_ALL=C date`"
