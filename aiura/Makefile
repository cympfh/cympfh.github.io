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

e: edit

git: index
	git add ./
	git commit -a -m "aiura/ `date`"

## posts

posts:
	for f in *.md; do make $${f%md}html; done

%.html: %.md
	$(eval DESCRIPTION := $(shell cat $^ | grep '^## ' | sed 's/^#* //g' | tr '\n' '/' | sed 's/ *$$//g'))
	cat $^ | awk -f script/post.awk | \
		unidoc -s \
		-V "description=$(DESCRIPTION)" \
		-B templates/post.header.html \
		-A ../resources/js/toc.html \
		--css ../resources/css/c.css \
		--css https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css \
		-o $@
