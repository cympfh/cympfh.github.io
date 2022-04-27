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
	unidoc -s \
		-V "description:$(DESCRIPTION)" \
		--template resources/templates/post.hbs \
		$^ \
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
