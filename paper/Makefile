.PHONY: all index posts new

all: index posts

index: *.md
	bash script/index.sh >index.html

edit:
	bash script/edit.sh

git:
	git add --all
	git commit -a -m "paper/ `date`"
	git push

## posts

posts:
	for f in *.md; do make $${f%md}html; done

%.html: %.md
	mdc <$^ | awk -f script/post.awk | \
		pandoc -s -t html5 \
		-B resources/header.html \
		-A ../resources/js/toc.html \
		--mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-AMS-MML_HTMLorMML \
		--css ../resources/css/c.css \
		--css https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css \
		-o $@
