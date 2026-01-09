.PHONY: build serve update-rs git clean

build:
	unibook build

serve:
	unibook serve

update-rs:
	git submodule update --remote procon-rs

git: index
	git add -A .
	git commit -m "procon/ `date`"
	git push

clean:
	rm *.html
