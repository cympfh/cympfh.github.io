all:
	for f in *.md; do make $${f%md}html; done

%.html: %.md
	pandoc -t html5 --mathml -s --css ../../resources/css/c.css -A ../../resources/js/toc.html $^ -o $@
