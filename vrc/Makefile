.PHONY: new edit index world

new:
	bash script/new.sh

edit:
	bash script/edit.sh

# copied from me/
index: index.html
index.html: index.md
	unidoc -s \
		$< \
		-o $@ \
		--css resources/css/me.css

world: world.html
world.html: script/world.sh src/postlist src/*.md
	bash script/world.sh

cache/description/%.html: src/%.md
	mkdir -p cache/description/
	cat $< | awk 'NR==2{print}' | sed 's/^% *//g' | unidoc > $@

cache/innerhtml/%.html: src/%.md
	mkdir -p cache/innerhtml/
	cat $< | awk 'NR>5{print}' | unidoc > $@

dev:
	bash script/hotcompile.sh

git: index
	git add ./
	git commit -a -m "vrc/ `date`"
