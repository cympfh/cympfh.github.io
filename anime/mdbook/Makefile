build: index years
	mdbook build
	rm -f ../*.html
	cp -r book/* ..
	rm -rf book

index:
	bash scripts/index.sh > src/README.md

years:
	bash scripts/year.sh
