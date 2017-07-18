all: index

index:
	mdc < index.md | pandoc -s -t html5 \
		--template ./index.template \
		--css resources/css/a.css \
		-o index.html

git:
	git add --all
	git commit -a -m "`date`"
	git push
