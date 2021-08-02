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
	cat $< | awk c++ | mdc | pandoc -t html5 -o $@

git: index.html
	git add ./
	git commit -m "anime/ $(shell LANG=C date)"

# ゴミだけ削除する
cache-clean:
	bash ./scripts/cache-clean.sh
