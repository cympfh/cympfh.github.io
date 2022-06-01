.PHONY: index posts edit

.DEFAULT_GOAL := all

all: posts index

index: *.md
	bash script/index.sh >index.html

edit:
	bash script/edit.sh

new:
	bash script/edit.sh "*new"

git: index posts
	git add --all
	git commit -a -m "paper/ `date`"

## posts

posts:
	for f in *.md; do make $${f%md}html; done

%.html: %.md
	cat <$^ | awk -f script/post.awk | \
		unidoc -s \
			-B templates/post.header.html \
			-A ../resources/js/toc.html \
			--css resources/css/c.css \
			--css ../resources/css/c.css \
			--css https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css \
			-o $@
