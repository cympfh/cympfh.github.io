all: index.html pages

pages: intro.html sheaf.html cat.html topos.html int.log.html higher.int.log.html

index.html: README.md
	pandoc -t html5 --mathml --css ../../../resources/css/c.css --css c.css -i $^ -o $@

%.html: %.md
	coffee ./mark_dot.coffee $^ > /tmp/a.md
	sed -i -f macros.sed /tmp/a.md
	pandoc -t html5 --mathml --css ../../../resources/css/c.css --css c.css -i /tmp/a.md -o $@
