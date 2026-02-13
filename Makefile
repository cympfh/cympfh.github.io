all: index

index:
	mdc < index.md | pandoc -s -t html5 \
		--template ./index.template \
		--css resources/css/index.css \
		-o index.html

me.html: me.md
	unidoc -s \
		$< \
		-o $@ \
		--css resources/css/me.css

git:
	git add --all
	git commit -a -m "`date`"
	git push

dev:
	python -m http.server 8080 --bind 0.0.0.0
