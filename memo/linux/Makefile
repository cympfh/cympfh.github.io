all: index.html
index.html: README.md
	pandoc -t html5 --mathjax -s --css ../../resources/css/c.css -A ../../resources/js/toc.html $^ -o $@

%.html: %.md
	pandoc -t html5 --mathjax -s --css ../../resources/css/c.css $^ -o $@

