.PHONY: all index posts new

all: index posts

index:
	bash script/index.sh >index.html

edit:
	bash script/edit.sh

git: index
	git add --all
	git commit -a -m "aiura/ `date`"
	git push

## posts

posts:
	for f in *.md; do make $${f%md}html; done

%.html: %.md
	mdc <$^ | awk -f script/post.awk | \
		pandoc -s -t html5 \
		-B templates/post.header.html \
		-A ../resources/js/toc.html \
		--mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-AMS-MML_HTMLorMML \
		--css ../resources/css/c.css \
		--css https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css \
		-o $@
