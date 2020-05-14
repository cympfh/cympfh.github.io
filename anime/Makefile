index.html: refresh pages
	./scripts/index.sh > $@

new:
	./scripts/edit.sh new

refresh:
	./scripts/edit.sh refresh

edit:
	./scripts/edit.sh

pages:
	for f in $(shell find src/ -type f -name '*.md'); do make $${f%md}html; done

%.html: %.md
	cat $< | awk c++ | pandoc -t html5 -o $@
