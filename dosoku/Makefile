build:
	mdbook build

clean:
	mdbook clean

git: build
	git add -A .
	git commit -m "dosoku/ $(shell LANG=C date)"
	git push
