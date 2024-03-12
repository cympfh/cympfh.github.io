.PHONY: new edit index

new:
	bash script/new.sh

edit:
	bash script/edit.sh

index: index.html
index.html: script/index.sh src/postlist src/*.md
	bash script/index.sh

cache/description/%.html: src/%.md
	mkdir -p cache/description/
	cat $< | awk 'NR==2{print}' | sed 's/^% *//g' | unidoc > $@

cache/innerhtml/%.html: src/%.md
	mkdir -p cache/innerhtml/
	cat $< | awk 'NR>5{print}' | unidoc > $@

dev:
	bash script/hotcompile.sh
