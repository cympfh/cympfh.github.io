.PHONY: all index pages git clean update-rs

all: index pages

index: index.html

index.html: menu.html
	bash resources/template.sh index.md > $@

menu.html: README.md
	bash resources/menu.sh < $^ >$@

pages: menu.html
	ls -1 *.md | grep -v README.md | sed 's/.*/make &/; s/.md$$/.html/g' | sh

update-rs:
	git submodule update --remote procon-rs

%.html: %.md menu.html
	bash resources/template.sh $< > $@

git: index
	git add -A .
	git commit -m "procon/ `date`"
	git push

clean:
	rm *.html
