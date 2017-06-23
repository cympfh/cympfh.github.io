all: index.html others
CSS := ../../../../../resources/css/c.css

others:
	for f in `ls -1 *.md|grep -v README`; do make $${f%md}html; done

index.html: README.md
	pandoc -s --css ${CSS} --css ./c.css -i $^ -t html5 --mathml -o $@

%.html: %.md
	pandoc -s --css ${CSS} --css ./c.css -i $^ -t html5 --mathml -o $@
