.PHONY: all index posts new

all: index posts

index: *.md
	bash script/index.sh >index.html

edit:
	bash script/edit.sh

git: index
	git add --all
	git commit -a -m "memo/ `date`"
	git push

## posts

posts:
	for f in *.md; do make $${f%md}html; done

%.html: %.md
	cat $^ | awk -f script/post.awk | \
		unidoc -s \
		-B templates/post.header.html \
		-A templates/post.footer.html \
		-A ../resources/js/toc.html \
		--css ../resources/css/c.css \
		--css https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css \
		-o $@

dev:
	python ./script/dev.py
