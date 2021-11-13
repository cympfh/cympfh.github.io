.PHONY: all index posts new

all: index posts

index:
	bash script/index.sh >index.html

dev:
	bash script/hotcompile.sh

new:
	bash script/edit.sh "*new"

edit:
	bash script/edit.sh

git: index
	git add ./
	git commit -a -m "aiura/ `date`"

## posts

posts:
	for f in *.md; do make $${f%md}html; done

%.html: %.md
	$(eval DESCRIPTION := $(shell cat $^ | grep '^## ' | sed 's/^#* //g' | tr '\n' '/' | sed 's/ *$$//g'))
	mdc <$^ | awk -f script/post.awk | \
		pandoc -s -t html5 \
		--template ./templates/post.body.html \
		-V "description=$(DESCRIPTION)" \
		-B templates/post.header.html \
		-A ../resources/js/toc.html \
		--mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-AMS-MML_HTMLorMML \
		--css ../resources/css/c.css \
		--css https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css \
		-o $@
