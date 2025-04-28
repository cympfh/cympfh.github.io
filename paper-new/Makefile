SRC_MD := $(wildcard src/**/*.md)
HTML := $(patsubst src/%.md,%.html,$(SRC_MD))

vpath %.md src

.PHONY: index index.html pages

index: index.html
index.html:
	bash script/index.sh > $@

pages: $(HTML)
%.html: %.md
	mkdir -p $(shell dirname $@)
	bash script/page.sh $< > $@

cache/%.html: %.md
	bash script/summaryblock.sh $< > $@

dev:
	bash script/hotcompile.sh

new:
	bash script/new.sh

edit:
	bash script/edit.sh
